require 'rake'
require 'jekyll'
require 'git'

def config
  # read Jekyll configuration
  conf = Jekyll::Configuration::DEFAULTS
  conf = conf.merge(jekyll_conf)
  dest_name = File.basename(conf['destination'])

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
                   'dest_name' => dest_name,
                   'remote' => remote,
                   'git_user' => repo.config('user.name'),
                   'git_email' => repo.config('user.email') }

  # check for errors
  destination_is_ignored = File.readlines('.gitignore').any? { |l| l.start_with?(dest_name) }
  destination_branch_exists = repo.branches.any? { |b| b.name == dest_branch }

  conf['errors'] = {}
  conf['errors']['username'] = ["can't determine username"] unless username
  conf['errors']['reponame'] = ["can't determine reponame"] unless reponame
  conf['errors']['destination'] = ["folder #{dest_name} must be .gitignored"] unless destination_is_ignored
  conf['errors']['dest_branch'] = ["branch #{dest_branch} must exist"] unless destination_branch_exists

  # return configuration as hash
  conf
end

# Helper functions

# read in jekyll configuration file
def jekyll_conf
  if File.exist? '_config.yml'
    # temporarily silence log output
    Jekyll.logger.log_level = Jekyll::Stevenson::ERROR
    yml = Jekyll::Configuration.new.read_config_file('_config.yml')
    Jekyll.logger.log_level = Jekyll::Stevenson::INFO

    yml
  else
    {}
  end
end

# check that configuration is valid
# otherwise exit with error message
def jekyll_check
  unless config['errors'].empty?
    Jekyll.logger.error "Error: #{config['errors']}"
    exit(1)
  end
end

def jekyll_build
  Jekyll::Commands::Build.process(config)
end

def jekyll_watch
  Jekyll::Commands::Build.process(config.merge('watch' => true))
end

def jekyll_serve
  Jekyll::Commands::Serve.process(config)
end

# detect pull request
def jekyll_request
  if ENV['TRAVIS_PULL_REQUEST'].to_s.to_i > 0
    Jekyll.logger.warn 'Pull request detected. Not proceeding with deploy.'
    exit(1)
  end
end

# clone repo into destination folder if it doesn't exist there
# checkout destination branch
def jekyll_pull
  if File.exist? config['repo']['dest_name']
    repo = Git.open(config['repo']['dest_name'])
  else
    repo = Git.clone(config['repo']['remote'], config['repo']['dest_name'])
  end
  Dir.chdir(config['repo']['dest_name']) do
    repo.branch(config['repo']['dest_branch']).checkout
  end
rescue => e
  Jekyll.logger.error "Error: #{e.message}"
  exit(1)
end

# git push destination folder to remote
def jekyll_push
  repo = Git.open(config['repo']['dest_name'])
  Dir.chdir(config['repo']['dest_name']) do
    repo.add(all: true)
    repo.commit_all("Updating to #{config['repo']['username']}/#{config['repo']['reponame']}@#{repo.log.last.sha[0..9]}.")
    repo.push(repo.remote('origin'), config['repo']['dest_branch'])
  end
rescue => e
  Jekyll.logger.error "Error: #{e.message}"
  exit(1)
end

namespace :site do
  desc "Check the site"
  task :check do
    jekyll_check

    Jekyll.logger.info "Repo configuration: #{config['repo']}"
  end

  desc "Clone the destination site"
  task :clone do
    jekyll_check
    jekyll_pull

    Jekyll.logger.info "Destination folder cloned from remote repo."
  end

  desc "Generate the site"
  task :build do
    jekyll_check
    jekyll_pull
    jekyll_build

    Jekyll.logger.info "Site built in destination folder."
  end

  desc "Generate the site and watch for changes"
  task :watch do
    jekyll_check
    jekyll_pull
    jekyll_watch
  end

  desc "Generate the site and serve locally"
  task :serve do
    jekyll_check
    jekyll_pull
    jekyll_serve
  end

  desc "Generate the site and push changes to remote origin"
  task :deploy do
    jekyll_request
    jekyll_check
    jekyll_pull
    jekyll_build
    jekyll_push

    Jekyll.logger.info "Updated branch #{config['dest_branch']} pushed to GitHub Pages."
  end
end
