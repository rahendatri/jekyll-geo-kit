# frozen_string_literal: true

require_relative "lib/jekyll/markdown_alternates/version"

Gem::Specification.new do |spec|
  spec.name     = "jekyll-markdown-alternates"
  spec.version  = Jekyll::MarkdownAlternates::VERSION
  spec.authors  = ["Rahenda"]
  spec.email    = ["rahendatri@users.noreply.github.com"]
  spec.license  = "MIT"

  spec.summary  = "Serve every Jekyll post as a Markdown alternate for GEO " \
                  "(Generative Engine Optimization)"
  spec.description = "Generates /<slug>.md companions for each post, declared via " \
                     "rel=alternate type=text/markdown, so LLM crawlers and AI agents " \
                     "can fetch clean Markdown instead of parsing HTML. Each document " \
                     "links back to the site's llms.txt index."

  spec.homepage = "https://github.com/rahendatri/jekyll-markdown-alternates"
  spec.metadata = {
    "source_code_uri" => spec.homepage,
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri"   => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "keywords"        => "jekyll, geo, generative-engine-optimization, llms-txt, " \
                         "markdown, ai-crawlers, seo",
  }

  spec.files = Dir["lib/**/*.rb"] + ["LICENSE", "README.md", "CHANGELOG.md"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "jekyll", ">= 4.0", "< 5.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
end
