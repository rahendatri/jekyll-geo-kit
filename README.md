# jekyll-markdown-alternates

Serve every Jekyll post as a Markdown alternate, for GEO (Generative Engine
Optimization).

An LLM crawler or AI agent that lands on `/2026/01/15/a-post.html` can fetch
`/2026/01/15/a-post.md` instead and get the same text as clean Markdown — no
HTML parsing, no navigation chrome, no boilerplate — with a pointer to your
site index at the top so it can discover the rest of the site.

```
> ## Site index
> Fetch the complete site index at: https://example.com/llms.txt
> Use it to discover every page on this site before exploring further.

# A published post
Source: https://example.com/2026/01/15/a-post.html
Published: 2026-01-15
Author: Rahenda
Language: en

> The post description, collapsed onto one line.

The body of the post, exactly as written, still in Markdown.
```

## Installation

```ruby
# Gemfile
group :jekyll_plugins do
  gem "jekyll-markdown-alternates"
end
```

Then declare the alternates in `_includes/head.html` so crawlers discover them:

```liquid
{%- if page.layout == "post" and page.unlisted != true %}
<link rel="alternate" type="text/markdown"
      title="{{ page.title }} — Markdown"
      href="{{ page.url | markdown_alternate_url }}" />
{%- endif %}
```

The `markdown_alternate_url` filter derives the path the same way the generator
does, so the two can't drift apart.

> **GitHub Pages:** this is a third-party plugin, so GitHub's own Jekyll builder
> will not run it. Build with a workflow (`actions/jekyll-build-pages` or
> `bundle exec jekyll build` → `upload-pages-artifact` → `deploy-pages`) instead.
> GitHub Pages serves `.md` as `text/markdown; charset=utf-8`.

## Configuration

Everything is optional. The defaults:

```yaml
markdown_alternates:
  enabled: true           # false turns the plugin off without removing the gem
  collections: [posts]    # which collections get alternates
  index: /llms.txt        # site index linked at the top; nil omits the banner
  extension: .md          # served extension
  skip_key: unlisted      # front-matter key that excludes a document
  authors_data: authors   # _data/<key>.yml looked up by the post's `author`
```

| Option | Notes |
| --- | --- |
| `enabled` | Set `false` to keep the gem installed but generate nothing. |
| `collections` | Any collection label, e.g. `[posts, docs]`. Collections with `output: false` are skipped automatically. |
| `index` | Absolute path on your site. Set to `nil` to drop the index banner entirely. |
| `extension` | `.md` by default; `.txt` if your host won't serve `.md` usefully. |
| `skip_key` | A document with `unlisted: true` gets no alternate. Set to `nil` to generate one for every document. |
| `authors_data` | Author name resolution: `_data/authors.yml` keyed by the post's `author`, then `site.author.name`, then the raw key. |

Drafts and `published: false` documents never get an alternate. Generated pages
carry `sitemap: false`, so `jekyll-sitemap` leaves them out.

## How it works

A `Jekyll::Generator` at `:low` priority adds one `PageWithoutAFile` per
document. The source name it reports ends in `.txt` on purpose: Jekyll picks its
converter from the source extension, so a `.txt` name leaves the Markdown body
unconverted, while the `permalink` decides the served path and extension.

## Development

```sh
bundle install
bundle exec rake spec
```

The suite builds a fixture site in `spec/fixtures` and asserts on the generated
pages.

## License

MIT — see [LICENSE](LICENSE).
