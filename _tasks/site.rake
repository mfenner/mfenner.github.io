require 'rake'
require 'jekyll'
require 'date'
require 'git'

def config
  # read Jekyll configuration
  conf = Jekyll::Configuration::DEFAULTS
  if File.exist? '_config.yml'
    Jekyll.logger.log_level = Jekyll::Stevenson::WARN
    jekyll_conf = Jekyll::Configuration.new.read_config_file('_config.yml')
    Jekyll.logger.log_level = Jekyll::Stevenson::INFO
    conf = conf.merge(jekyll_conf)
  end
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
  destination_branch_exists = repo.branches.any? { |b| b.name == dest_branch && b.remote.nil? }

  conf['errors'] = {}
  conf['errors']['username'] = ["can't determine username"] unless username
  conf['errors']['reponame'] = ["can't determine reponame"] unless reponame
  conf['errors']['destination'] = ["folder #{dest_name} must be .gitignored"] unless destination_is_ignored
  conf['errors']['dest_branch'] = ["branch #{dest_branch} must exist"] unless destination_branch_exists

  # return configuration as hash
  conf
end

# Helper functions

# check that configuration is valid
def config_not_valid?
  if config['errors'].empty?
    false
  else
    Jekyll.logger.error "Error: #{config['errors']}"
    true
  end
end

# clone repo into destination folder if it doesn't exist there
# checkout destination branch
def git_clone_failed?
  if File.exist? config['repo']['dest_name']
    repo = Git.open(config['repo']['dest_name'])
    repo.pull
  else
    repo = Git.clone(config['repo']['remote'], config['repo']['dest_name'])
  end
  Dir.chdir(config['repo']['dest_name']) do
    repo.branch(config['repo']['dest_branch']).checkout
  end
  false
rescue => e
  Jekyll.logger.error "Error: #{e.message}"
  true
end

# detect pull request
def pull_request?
  if ENV['TRAVIS_PULL_REQUEST'].to_s.to_i > 0
    Jekyll.logger.warn 'Pull request detected. Not proceeding with deploy.'
    exit
  else
    false
  end
end

# git push destination folder to remote
def git_push_failed?
  repo = Git.open(config['repo']['dest_name'])
  Dir.chdir(config['repo']['dest_name']) do
    repo.add(:all=>true)
    repo.commit_all "Updating to #{config['repo']['username']}/#{config['repo']['reponame']}@#{repo.log.last.sha}.'"
    repo.push(repo.remote('origin'), config['repo']['dest_branch'])
  end
  false
rescue => e
  Jekyll.logger.error "Error: #{e.message}"
  true
end

namespace :site do

  desc "Check the site"
  task :check do
    exit if config_not_valid?

    Jekyll.logger.info "Configuration: #{config['repo']}"
  end

  desc "Clone the destination site"
  task :clone do
    exit if config_not_valid?
    exit if git_clone_failed?

    Jekyll.logger.info "Destination folder cloned from remote repo."
  end

  desc "Generate the site"
  task :build do
    exit if config_not_valid?
    exit if git_clone_failed?

    sh "bundle exec jekyll build"
  end

  desc "Generate the site and serve locally"
  task :serve do
    exit if config_not_valid?
    exit if git_clone_failed?

    sh "bundle exec jekyll serve"
  end

  desc "Generate the site, serve locally and watch for changes"
  task :watch do
    exit if config_not_valid?
    exit if git_clone_failed?

    sh "bundle exec jekyll serve --watch"
  end

  desc "Generate the site and push changes to remote origin"
  task :deploy do

    exit if pull_request?
    exit if config_not_valid?
    exit if git_clone_failed?

    # Generate the site
    sh "bundle exec jekyll build"

    exit if git_push_failed?

    Jekyll.logger.info "Pushed updated branch #{config['dest_branch']} to GitHub Pages."
  end
end
