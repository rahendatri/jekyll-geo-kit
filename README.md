## About jekyll-geo-kit

A Jekyll plugin that serves every post as clean Markdown alongside its HTML, so
LLM crawlers and AI agents can read your content without parsing a page — GEO
(Generative Engine Optimization).

[![CI](https://github.com/rahendatri/jekyll-geo-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/rahendatri/jekyll-geo-kit/actions/workflows/ci.yml)


## Quick start

Add the gem to your site's `Gemfile`, in the `:jekyll_plugins` group so Bundler
loads it for you:

```ruby
group :jekyll_plugins do
  gem "jekyll-geo-kit"
end
```

Then run `bundle install`.

If you prefer to list your plugins in configuration instead, add it to
`_config.yml`:

```yaml
plugins:
  - jekyll-geo-kit
```

That's it ! The plugin generates `.md` for every post.


## Using GitHub Pages

`jekyll-geo-kit` is a third-party plugin, so GitHub's own Jekyll builder will not 
run it.

Build your own workflow instead:

1. Use or adapt the example here : [custom-jekyll-github-action](https://github.com/rahendatri/rahendatri.github.io/blob/main/.github/workflows/jekyll.yml)
2.  Activate the custom Github Pages workflow by choosing `Github Actions` in the following place: `<project-settings> / Pages / Build and Deployment / Source`



## What it does

jekyll-geo-kit generates a Markdown alternate at `/<slug>.md` for every written
document in the configured collections. Each one contains:

* A pointer to your site index (`llms.txt` by default), so an agent that lands
  on one document can discover the rest of the site
* The document's metadata as plain lines — title, canonical source URL,
  publication date, resolved author name, language
* The description collapsed onto a single quoted line
* The body exactly as you wrote it, still in Markdown and never converted to
  HTML

It also includes the `markdown_alternate_url` Liquid filter, so the
`<link rel="alternate" type="text/markdown">` you put in `head.html` derives its
path through the same logic the generator used and the two cannot drift apart.

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

While you could write this generator yourself, jekyll-geo-kit keeps the served
paths, the metadata format and the `rel=alternate` declaration in one place.

## What it doesn't do

jekyll-geo-kit only generates the Markdown documents and the filter that links
them. It does not write your `llms.txt` index — it links to whatever path you
point `index` at, and leaves creating that file to you or to another plugin.

It does not inject anything into your HTML. Declaring the alternates is a
one-line Liquid snippet you add to your own `head.html`, documented under
[Usage](docs/usage.md).

It does not convert HTML to Markdown. The alternates carry the document's
unrendered source body, so a document authored in Markdown round-trips exactly
while one authored in HTML is served as that HTML.

It covers collection documents — `posts` by default, any collection you
configure — and not standalone pages like `about.md`.

Being a third-party plugin, it does not run on GitHub's own Jekyll builder; see
[Installation](docs/installation.md) for the workflow that does.

## Documentation

For more information, see:

* [Installation](docs/installation.md)
* [Usage](docs/usage.md)
* [Advanced usage](docs/advanced-usage.md)

## License

MIT — see [LICENSE](LICENSE).
