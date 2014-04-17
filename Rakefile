#############################################################################
#
# Modified version of jekyllrb Rakefile
# https://github.com/jekyll/jekyll/blob/master/Rakefile
#
#############################################################################

import '_tasks/site.rake'

# File activesupport/lib/active_support/inflector/transliterate.rb, line 80
def parameterize(string, sep = '-')
  # replace accented chars with their ascii
  # simplified from original to remove dependency
  parameterized_string = string.dup.force_encoding('US-ASCII')
  # Turn unwanted chars into the separator
  # changed from original: allow A-Z
  parameterized_string.gsub!(/[^a-zA-Z0-9\-_]+/, sep)
  unless sep.nil? || sep.empty?
    re_sep = Regexp.escape(sep)
    # No more than one of the separator in a row.
    parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
    # Remove leading/trailing separator.
    parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/, '')
  end
  parameterized_string.downcase
end

namespace :post do
  desc "Create a new post"
  task :create do
    title = ENV["title"] || "new-post"
    begin
      slug = parameterize(title)
      puts slug
    rescue => e
      puts "Error: invalid characters in title"
      exit -1
    end

    begin
      date = ENV['date'] ? Date.parse(ENV['date']) : Date.today
    rescue => e
      puts "Error: date format must be YYYY-MM-DD"
      exit -1
    end

    filename = File.join("_posts", "#{date}-#{slug}.md")
    if File.exist?(filename)
      puts "Error: post already exists"
      exit -1
    end

    header = { "layout" => "post", "title" => title }
    content = header.to_yaml + "---\n"

    if IO.write(filename, content)
      puts "Post #{filename} created"
    else
      puts "Error: #{filename} could not be written"
    end
  end
end

namespace :page do
  desc "Create a new page"
  task :create do
    title = ENV["title"] || "new-page"
    begin
      slug = parameterize(title)
      puts slug
    rescue => e
      puts "Error: invalid characters in title"
      exit -1
    end

    folder = ENV["folder"] || "."

    filename = File.join(folder, "#{slug}.md")
    if File.exist?(filename)
      puts "Error: page already exists"
      exit -1
    end

    header = { "layout" => "page", "title" => title }
    content = header.to_yaml + "---\n"

    if IO.write(filename, content)
      puts "Page #{filename} created"
    else
      puts "Error: #{filename} could not be written"
    end
  end
end
