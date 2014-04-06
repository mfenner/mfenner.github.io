# encoding: UTF-8

# we are overriding the default Jekyll Markdown class:
# https://github.com/jekyll/jekyll/blob/master/lib/jekyll/converters/markdown.rb

require 'open3'

class Jekyll::Converters::Markdown

  KNITR_CHUNK = "\n```{r"

  def convert(content)
    setup

    # do extra knitr step if we find a knitr code chunk
    content = knit(content) if content.include? KNITR_CHUNK

    @parser.convert(content)
  end

  # call knitr with options
  def knit(content)
    command = "_plugins/knitrscript.R --args #{options}"

    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      stdin.puts content
      stdin.close

      raise StandardError, "Error knitting: #{stderr.read}" if wait_thr.value.exitstatus > 0
      content = stdout.read
    end

    # fix img links for the figures that were generated
    content = content.gsub("../mfenner.github.io-pages/", "/")
  end

  # merge default options and options from _config.yml
  # turn into string with named args, e.g. fig.width=10
  def options
    opts = { "root.dir" => nil,
             "fig.show" => "hold",
             "fig.path" => "#{@config['destination']}figures/",
             "fig.width" => 10,
             "fig.height" => 7,
             "dev" => "svg",
             "warning" => false }.merge(@config['knitr'])
    opts.map {|k,v| "#{k}=#{v}" }.join(" ")
  end

end