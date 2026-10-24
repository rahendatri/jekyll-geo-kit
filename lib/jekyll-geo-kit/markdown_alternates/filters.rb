# frozen_string_literal: true

module Jekyll
  module GeoKit
    module MarkdownAlternates
      # Liquid filter so a template links the alternate through the same path
      # logic the generator used:
      #
      #   <link rel="alternate" type="text/markdown"
      #         href="{{ page.url | markdown_alternate_url }}">
      module Filters
        def markdown_alternate_url(url)
          site = @context.registers[:site]
          extension = Config.new(site).extension
          path = MarkdownAlternates.alternate_path(url, extension)

          baseurl = site.config["baseurl"].to_s.chomp("/")
          "#{baseurl}#{path}"
        end
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::GeoKit::MarkdownAlternates::Filters)
