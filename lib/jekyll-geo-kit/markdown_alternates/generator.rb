# frozen_string_literal: true

module Jekyll
  module GeoKit
    module MarkdownAlternates
      class Generator < Jekyll::Generator
        safe true
        priority :low

        def generate(site)
          config = Config.new(site)
          return unless config.enabled?

          documents(site, config).each do |document|
            next if skip?(document, config)

            site.pages << Page.new(site, document, config)
          end
        end

        private

        def documents(site, config)
          config.collections.flat_map do |label|
            collection = site.collections[label]
            collection ? collection.docs : []
          end
        end

        # Leaves out drafts, `published: false`, output-less collections and
        # anything the site marks with the configured skip key.
        def skip?(document, config)
          return true unless document.write?

          key = config.skip_key
          return false if key.nil?

          document.data[key] == true
        end
      end
    end
  end
end
