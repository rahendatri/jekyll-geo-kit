# frozen_string_literal: true

require "spec_helper"

RSpec.describe Jekyll::GeoKit::MarkdownAlternates do
  context "with the default configuration" do
    let(:site) { build_site }
    let(:pages) { alternates(site) }
    let(:post) { pages["/2026/01/15/a-published-post.md"] }

    it "generates one alternate per written post" do
      expect(pages.keys).to contain_exactly(
        "/2026/01/15/a-published-post.md",
        "/2026/03/01/a-minimal-post.md",
      )
    end

    it "skips posts marked with the skip key" do
      expect(pages.keys).not_to include(a_string_matching(/an-unlisted-post/))
    end

    it "points at the site index before anything else" do
      expect(post.content).to start_with(<<~MARKDOWN.chomp)
        > ## Site index
        > Fetch the complete site index at: https://example.com/llms.txt
        > Use it to discover every page on this site before exploring further.
      MARKDOWN
    end

    it "writes the document metadata as plain lines" do
      expect(post.content).to include(
        "# A published post\n" \
        "Source: https://example.com/2026/01/15/a-published-post.html\n" \
        "Published: 2026-01-15\n" \
        "Author: Rahenda\n" \
        "Language: fr\n",
      )
    end

    it "collapses the description onto one quoted line" do
      expect(post.content).to include("> A description with loose whitespace.")
    end

    it "keeps the Markdown body unconverted" do
      expect(post.content).to include("Some **Markdown** body text.")
      expect(post.content).not_to include("<strong>")
    end

    it "falls back to the site author and language" do
      minimal = pages["/2026/03/01/a-minimal-post.md"]

      expect(minimal.content).to include("Author: Site Owner")
      expect(minimal.content).to include("Language: en")
      expect(minimal.content).not_to include(">\n")
    end

    it "keeps the alternates out of the sitemap" do
      expect(post.data["sitemap"]).to be(false)
    end

    it "renders them without a layout" do
      expect(post.data["layout"]).to be_nil
    end

    it "writes the file to the served path" do
      site

      expect(File).to exist(File.join(DEST, "2026/01/15/a-published-post.md"))
    end
  end

  context "when configured" do
    it "can be turned off entirely" do
      site = build_site("markdown_alternates" => { "enabled" => false })

      expect(alternates(site)).to be_empty
    end

    it "omits the index banner when no index is set" do
      site = build_site("markdown_alternates" => { "index" => nil })
      post = alternates(site)["/2026/01/15/a-published-post.md"]

      expect(post.content).to start_with("# A published post")
    end

    it "honours a custom extension" do
      site = build_site("markdown_alternates" => { "extension" => ".txt" })

      expect(alternates(site).keys).to include("/2026/01/15/a-published-post.txt")
    end

    it "generates an alternate for every post when the skip key is disabled" do
      site = build_site("markdown_alternates" => { "skip_key" => nil })

      expect(alternates(site).keys).to include("/2026/02/20/an-unlisted-post.md")
    end
  end

  describe ".alternate_path" do
    it "replaces an .html extension" do
      expect(described_class.alternate_path("/a/post.html")).to eq("/a/post.md")
    end

    it "strips a trailing slash from a pretty permalink" do
      expect(described_class.alternate_path("/a/post/")).to eq("/a/post.md")
    end
  end
end
