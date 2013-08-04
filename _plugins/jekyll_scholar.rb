require 'jekyll/scholar'

module Jekyll
  class Scholar
    module Utilities

      alias_method :original_reference_tag, :reference_tag

      def reference_tag(entry)
        return missing_reference unless entry

        # Change URLs into markdown links
        entry["url"] = "[#{entry["url"]}](#{entry["url"]})" if entry["url"]

        entry = entry.convert(*bibtex_filters) unless bibtex_filters.empty?
        reference = CiteProc.process entry.to_citeproc,
          :style => style, :locale => config['locale'], :format => 'html'

        content_tag reference_tagname, reference,
          :id => [prefix, entry.key].compact.join('-')
      end
    end
  end
end
