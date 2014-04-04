require 'open3'

module Jekyll
  module Converters
    class Markdown < Converter
      safe false

      # to allow pandoc parsing, we override the setup method from
      # https://github.com/jekyll/jekyll/blob/master/lib/jekyll/converters/markdown.rb
      def setup
        return if @setup
        @parser =
          case @config['markdown'].downcase
            when 'redcarpet' then RedcarpetParser.new(@config)
            when 'kramdown' then KramdownParser.new(@config)
            when 'rdiscount' then RDiscountParser.new(@config)
            when 'maruku' then MarukuParser.new(@config)
            when 'pandoc' then PandocParser.new(@config)
          else
            # So they can't try some tricky bullshit or go down the ancestor chain, I hope.
            if allowed_custom_class?(@config['markdown'])
              self.class.const_get(@config['markdown']).new(@config)
            else
              Jekyll.logger.error "Invalid Markdown Processor:", "#{@config['markdown']}"
              Jekyll.logger.error "", "Valid options are [ maruku | rdiscount | kramdown | redcarpet | pandoc ]"
              raise FatalException, "Invalid Markdown Processor: #{@config['markdown']}"
            end
          end
        @setup = true
      end

      class PandocParser

        def initialize(config)
          require 'open3'
          @config = config
        rescue LoadError
          raise FatalException.new("Missing dependency: pandoc")
        end

        def convert(content)
          opts = options(content).map {|k,v| v.nil? ? "--#{k}" : "--#{k}=#{v}" }.join(" ")
          command = "pandoc -f markdown -t html5 --filter pandoc-citeproc #{opts}"

          Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
            stdin.puts content
            stdin.close

            content = stdout.read
            exit_status = wait_thr.value
            if exit_status.success?
              Jekyll.logger.info "Converting #{stdout.read}"
            else
              Jekyll.logger.error "Error converting pandoc #{stderr.read}"
            end
            content
          end
        end

        # pandoc options, using reasonable defaults
        # priority in increasing order:
        # - defaults
        # - site
        # - page
        def default_options
          { "smart" => nil,
            "mathjax" => nil }
        end

        def site_options
          @config['pandoc'] || {}
        end

        def page_options(content)
          if content =~ /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
            data = YAML.load($1)["pandoc"] || {}
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
end