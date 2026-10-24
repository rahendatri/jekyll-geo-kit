# frozen_string_literal: true

module Jekyll
  module GeoKit
    module MarkdownAlternates
      # The generated page for one document's Markdown alternate.
      #
      # The source name ends in .txt on purpose: Jekyll picks its converter from
      # the source extension, so a .txt name leaves the Markdown body alone, while
      # the permalink decides the served path (/<slug>.md) and the output
      # extension. GitHub Pages serves .md as text/markdown; charset=utf-8.
      class Page < Jekyll::PageWithoutAFile
        def initialize(site, document, config)
          super(site, site.source, "", "#{document.basename_without_ext}.txt")

          self.data = {
            "layout"    => nil,
            "permalink" => MarkdownAlternates.alternate_path(document.url, config.extension),
            "sitemap"   => false,
            "title"     => document.data["title"],
          }
          self.content = Body.new(site, document, config).to_s
        end
      end
    end
  end
end
