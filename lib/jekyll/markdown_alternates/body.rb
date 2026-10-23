# frozen_string_literal: true

module Jekyll
  module MarkdownAlternates
    # The Markdown text served at /<slug>.md: a pointer to the site index, the
    # document's metadata as plain lines, then its unrendered body.
    class Body
      def initialize(site, document, config)
        @site = site
        @document = document
        @config = config
      end

      def to_s
        (banner + heading + description + content).join("\n")
      end

      private

      def banner
        index_url = @config.index_url
        return [] if index_url.nil?

        [
          "> ## Site index",
          "> Fetch the complete site index at: #{index_url}",
          "> Use it to discover every page on this site before exploring further.",
          "",
        ]
      end

      def heading
        lines = ["# #{@document.data["title"]}"]
        lines << "Source: #{MarkdownAlternates.absolute_url(@site, @document.url)}"
        lines << "Published: #{date.strftime("%Y-%m-%d")}" if date
        lines << "Author: #{author_name}" if author_name
        lines << "Language: #{language}"
        lines
      end

      def description
        text = @document.data["description"].to_s.strip.gsub(/\s+/, " ")
        return [] if text.empty?

        ["", "> #{text}"]
      end

      def content
        ["", @document.content.to_s.strip, ""]
      end

      def date
        @document.data["date"] || (@document.respond_to?(:date) ? @document.date : nil)
      end

      # Prefers the matching entry in _data/<authors_data>.yml, then the site's
      # single-author config.
      def author_name
        key = @document.data["author"].to_s
        author = @site.data.dig(@config.authors_data, key) || {}
        name = author["name"] if author.is_a?(Hash)
        name ||= @site.config.dig("author", "name")
        name ||= (key unless key.empty?)
        name
      end

      def language
        @document.data["lang"] || @site.config["lang"] || "en"
      end
    end
  end
end
