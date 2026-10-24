## Usage

Once the gem is installed, the generator runs on every build and needs no
configuration. A post at `/2026/01/15/a-post.html` gets an alternate at
`/2026/01/15/a-post.md` holding the site-index banner, the document's metadata
and its unconverted Markdown body.

### Declaring the markdown alternates in HTML

Crawlers find the alternates through your HTML, so add this to
`_includes/head.html`:

```liquid
{%- if page.layout == "post" and page.unlisted != true %}
<link rel="alternate" type="text/markdown"
      title="{{ page.title }} — Markdown"
      href="{{ page.url | markdown_alternate_url }}" />
{%- endif %}
```

The `markdown_alternate_url` filter derives the path the same way the generator
does — including your `baseurl` and any custom `extension` — so the link and the
generated document cannot drift apart.

### What gets an alternate

Every document that Jekyll writes, in each configured collection (`posts` by
default), with these exceptions:

* A `published: false` document never gets one.
* Drafts get none in a normal build, because Jekyll doesn't read `_drafts` at
  all. Building with `--drafts` reads them as posts, so they do get alternates.
* Collections declared `output: false` are skipped.
* A document marked with the skip key — `unlisted: true` by default — is left
  out. This is the same flag the Liquid snippet above checks.

Generated pages carry `sitemap: false`, so [jekyll-sitemap][sitemap] leaves them
out of `sitemap.xml`, and they render with no layout.

### Author and language

The author line resolves in order: the matching entry in `_data/authors.yml`
keyed by the post's `author`, then `site.author.name` from `_config.yml`, then
the raw `author` value. The language line uses the document's `lang`, then
`site.lang`, then `en`.

For the configuration options behind all of this, see
[Advanced usage](advanced-usage.md).

[sitemap]: https://github.com/jekyll/jekyll-sitemap
