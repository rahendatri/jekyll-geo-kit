# frozen_string_literal: true

module Jekyll
  module MarkdownAlternates
    # The `markdown_alternates:` block of _config.yml, with the defaults a site
    # gets when it says nothing at all.
    class Config
      DEFAULTS = {
        "enabled"      => true,
        "collections"  => ["posts"],
        "index"        => "/llms.txt",
        "extension"    => ".md",
        "skip_key"     => "unlisted",
        "authors_data" => "authors",
      }.freeze

      def initialize(site)
        @site = site
        overrides = site.config["markdown_alternates"]
        @options = DEFAULTS.merge(overrides.is_a?(Hash) ? overrides : {})
      end

      def enabled?
        @options["enabled"] != false
      end

      def collections
        Array(@options["collections"]).map(&:to_s)
      end

      def extension
        ext = @options["extension"].to_s
        ext.empty? ? DEFAULTS["extension"] : ext
      end

      # Front-matter key that excludes a document from the alternates, e.g.
      # `unlisted: true`. Set to nil/false to generate one for every document.
      def skip_key
        key = @options["skip_key"]
        return nil if key.nil? || key == false || key.to_s.empty?

        key.to_s
      end

      def authors_data
        @options["authors_data"].to_s
      end

      # Absolute URL of the site index linked at the top of every alternate, or
      # nil when the site has none and the banner should be left out.
      def index_url
        path = @options["index"]
        return nil if path.nil? || path == false || path.to_s.empty?

        MarkdownAlternates.absolute_url(@site, path)
      end
    end
  end
end
