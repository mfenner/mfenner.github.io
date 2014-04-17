require 'rake'
require 'jekyll'
require 'git'

def config
  # read Jekyll configuration
  conf = Jekyll::Configuration::DEFAULTS
  if File.exist? '_config.yml'
    conf = conf.merge(Jekyll::Configuration.new.read_config_file('_config.yml'))
  end
  dest_folder = File.basename(conf['destination'])

  # read git repo information
  repo = Git.open(conf['source'])
  remote = repo.remote(:origin).url

  remote =~ /.*github\.com[:\/](.*)\/(.*)\.git/
  username, reponame = $1, $2
  source_branch = repo.branches.find { |b| b.current && b.remote.nil? }.name
  dest_branch = reponame.start_with?(username) ? 'master' : 'gh-pages'

  conf['repo'] = { 'username' => username,
                   'reponame' => reponame,
                   'source_branch' => source_branch,
                   'dest_branch' => dest_branch,
                   'dest_folder' => dest_folder,
                   'remote' => remote,
                   'git_user' => repo.config('user.name'),
                   'git_email' => repo.config('user.email') }

  # check for errors
  destination_is_ignored = File.readlines('.gitignore').any? { |l| l.start_with?(dest_folder) }
  # destination_branch_exists = repo.branches.any? { |b| b.name == dest_branch }

  conf['errors'] = {}
  conf['errors']['username'] = ["can't determine username"] unless username
  conf['errors']['reponame'] = ["can't determine reponame"] unless reponame
  conf['errors']['destination'] = ["folder #{dest_folder} must be .gitignored"] unless destination_is_ignored
  # conf['errors']['dest_branch'] = ["branch #{dest_branch} must exist"] unless destination_branch_exists

  # return configuration as hash
  conf
end

class Site

  attr_reader :config

  def initialize(config)
    @config = config
  end

  # check that configuration is valid
  # otherwise exit with error message
  def validate
    if config['errors'].empty?
      Jekyll.logger.info "Repo configuration: #{config['repo']['remote']}"
      Jekyll.logger.info output
    else
      Jekyll.logger.error "Error: #{config['errors']}"
      exit(1)
    end
  end

  def build
    Jekyll::Commands::Build.process(config)
  end

  def watch
    Jekyll::Commands::Build.process(config.merge('watch' => true))
  end

  def serve
    Jekyll::Commands::Serve.process(config)
  end

  # detect pull request
  def request
    if ENV['TRAVIS_PULL_REQUEST'].to_s.to_i > 0
      Jekyll.logger.warn 'Pull request detected. Not proceeding with deploy.'
      exit(1)
    end
  end

  # clone repo into destination folder if it doesn't exist there
  # checkout destination branch
  def pull
    if File.exist? config['repo']['dest_folder']
      Jekyll.logger.info "Opening repo:       #{config['repo']['remote']}"
      repo = Git.open(config['repo']['dest_folder'])

      Jekyll.logger.info "Git pull:           #{config['repo']['remote']}"
      repo.pull
    else
      Jekyll.logger.info "Cloning repo:       #{config['repo']['remote']}"
      Jekyll.logger.info "Destination:        #{config['repo']['dest_folder']}"

      if ENV["TRAVIS"]
        remote = "https://#{config['repo']['git_user']}:#{ENV['GH_TOKEN']}@github.com/#{config['repo']['username']}/#{config['repo']['reponame']}.git"
        repo = Git.clone(remote, config['repo']['dest_folder'])
      else
        repo = Git.clone(config['repo']['remote'], config['repo']['dest_folder'])
      end
    end

    Dir.chdir(config['repo']['dest_folder']) do
      Jekyll.logger.info "Checkout to branch: #{config['repo']['dest_branch']}"
      repo.branch(config['repo']['dest_branch']).checkout
    end
  rescue => e
    Jekyll.logger.error "Error: #{e.message}"
    exit(1)
  end

  # git push destination folder to remote
  def push
    repo = Git.open(config['repo']['dest_folder'])

    if ENV["TRAVIS"]
      repo.config('user.name', config['repo']['git_user'])
      repo.config('user.email', config['repo']['git_email'])
    end

    Dir.chdir(config['repo']['dest_folder']) do
      Jekyll.logger.info "Git add all:        #{config['repo']['dest_folder']}"
      repo.add(all: true)

      Jekyll.logger.info "Git commit all:     #{config['repo']['dest_folder']}"
      repo.commit_all("Updating to #{config['repo']['username']}/#{config['repo']['reponame']}@#{repo.log.last.sha[0..9]}.")

      Jekyll.logger.info "Git push to remote: #{config['repo']['remote']}"
      Jekyll.logger.info "Branch:             #{config['repo']['dest_branch']}"
      repo.push(repo.remote('origin'), config['repo']['dest_branch'])
      Jekyll.logger.info "GitHub Pages updated."
    end
  rescue => e
    Jekyll.logger.error "Error: #{e.message}"
    exit(1)
  end

  def output
    hash = config['repo'].select { |k| k != 'remote' }
    hash.map { |k, v| "                    #{k}: #{v}" }.join("\n")
  end
end

namespace :site do
  @site = Site.new(config)

  desc "Validate the site"
  task :validate do
    @site.validate
  end

  desc "Clone the destination site"
  task :clone do
    @site.validate
    @site.pull
  end

  desc "Generate the site"
  task :build do
    @site.validate
    @site.pull
    @site.build
  end

  desc "Generate the site and watch for changes"
  task :watch do
    @site.validate
    @site.pull
    @site.watch
  end

  desc "Generate the site and serve locally"
  task :serve do
    @site.validate
    @site.pull
    @site.serve
  end

  desc "Generate the site and push changes to remote origin"
  task :deploy do
    @site.request
    @site.validate
    @site.pull
    @site.build
    @site.push
  end
end
