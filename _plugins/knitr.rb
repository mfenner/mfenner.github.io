# encoding: UTF-8

# we are overriding the default Jekyll Markdown class:
# https://github.com/jekyll/jekyll/blob/master/lib/jekyll/converters/markdown.rb

require 'open3'

module Jekyll
  module Converters
    class Markdown < Converter
      safe false

      def matches(ext)
        rgx = '^\.(' + @config['markdown_ext'].gsub(',','|') +')$'
        ext =~ Regexp.new(rgx, Regexp::IGNORECASE)
      end

      def matches_knitr(ext)
        ext =~ /\.Rmd$/i
      end

      def convert(content)
        setup

        # TODO do extra knitr step only for Rmarkdown files
        content = knit(content) # if matches_knitr(ext)

        @parser.convert(content)
      end

      # call knitr, options are used as named args, e.g. fig.width=10
      def knit(content)
        opts = options(content).map {|k,v| "#{k}=#{v}" }.join(" ")
        command = "_plugins/knitrscript.R --args #{opts}"

        Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
          stdin.puts content
          stdin.close

          exit_status = wait_thr.value
          if exit_status.success?
            Jekyll.logger.info "Knitting"
          else
            Jekyll.logger.error "Error knitting: #{stderr.read}"
          end
          content = stdout.read
        end

        # fix img links for the figures that were generated
        content = content.gsub("../mfenner_github_io-pages/", "/")
      end

      # knitr options, using reasonable defaults
      # priority in increasing order:
      # - defaults
      # - site
      # - page
      def default_options
        { "root.dir" => nil,
          "fig.show" => "hold",
          "fig.path" => "#{@config['destination']}figures/",
          "fig.width" => 10,
          "fig.height" => 7,
          "dev" => "svg",
          "warning" => false }
      end

      def site_options
        @config['knitr'] || {}
      end

      def page_options(content)
        if content =~ /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
          data = YAML.load($1)["knitr"] || {}
        else
          data = {}
        end
      end

      def options(content)
        opts = default_options
        opts = opts.merge(site_options)
        opts = opts.merge(page_options(content))
      end

    end
  end
end