# frozen_string_literal: true

require "jekyll"
require "jekyll-markdown-alternates"
require "fileutils"

FIXTURES = File.expand_path("fixtures", __dir__)
DEST     = File.expand_path("dest", __dir__)

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.order = :random

  config.before do
    Jekyll.logger.log_level = :error
  end

  config.after(:suite) do
    FileUtils.rm_rf(DEST)
    FileUtils.rm_rf(File.join(FIXTURES, ".jekyll-cache"))
  end
end

# Builds the fixture site, merging any extra config on top of _config.yml.
def build_site(overrides = {})
  config = Jekyll.configuration(
    overrides.merge(
      "source"      => FIXTURES,
      "destination" => DEST,
      "quiet"       => true,
    ),
  )
  Jekyll::Site.new(config).tap(&:process)
end

# The pages this plugin generated, keyed by served path.
def alternates(site)
  site.pages
      .grep(Jekyll::MarkdownAlternates::Page)
      .to_h { |page| [page.data["permalink"], page] }
end
