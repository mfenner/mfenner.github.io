require 'jekyll/scholar'
require 'uri'

module MarkdownFilter
  class Markdown < BibTeX::Filter
    def apply(value)
      url = value.to_s.slice(URI.regexp(['http','https','ftp']))
      return value unless url
      value.to_s.gsub(url, "[#{url}](#{url})")
    end
  end
end
