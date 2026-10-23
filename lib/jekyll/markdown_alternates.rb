# frozen_string_literal: true

require "jekyll"

require_relative "markdown_alternates/version"
require_relative "markdown_alternates/config"
require_relative "markdown_alternates/body"
require_relative "markdown_alternates/page"
require_relative "markdown_alternates/generator"
require_relative "markdown_alternates/filters"

# Markdown alternates: /<slug>.md for every published document.
#
# An AI agent that lands on a page can fetch the same text as Markdown instead
# of parsing the HTML, and finds a pointer to the site index at the top of it.
# Declare the pages from head.html with
# <link rel="alternate" type="text/markdown">.
module Jekyll
  module MarkdownAlternates
    # Joins site.url and site.baseurl onto an absolute path. Jekyll's own
    # absolute_url filter needs a Liquid context, so the generator does it here.
    def self.absolute_url(site, path)
      base = site.config["url"].to_s.chomp("/")
      baseurl = site.config["baseurl"].to_s
      baseurl = "" if baseurl == "/"
      "#{base}#{baseurl.chomp("/")}#{path}"
    end

    # The served path of a document's Markdown alternate: /a/post/ -> /a/post.md
    def self.alternate_path(url, extension = ".md")
      url.to_s.sub(%r{\.html\z}, "").sub(%r{/\z}, "") + extension
    end
  end
end
