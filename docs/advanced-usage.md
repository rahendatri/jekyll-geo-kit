## Advanced usage

### Configuration

Everything is optional. The defaults, in `_config.yml`:

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
| `extension` | `.md` by default; `.txt` if your host won't serve `.md` usefully. The `markdown_alternate_url` filter follows this setting. |
| `skip_key` | A document with `unlisted: true` gets no alternate. Set to `nil` to generate one for every document. |
| `authors_data` | Author name resolution: `_data/authors.yml` keyed by the post's `author`, then `site.author.name`, then the raw key. |

### Serving another extension

Hosts that won't serve `.md` as readable text can use `extension: .txt`. Both
the generated path and the `rel=alternate` link follow it, so no template change
is needed.

### Covering more collections

`collections` takes any collection label, so a documentation collection gets
alternates alongside your posts:

```yaml
collections:
  docs:
    output: true

markdown_alternates:
  collections: [posts, docs]
```

### How it works

A `Jekyll::Generator` running at `:low` priority adds one `PageWithoutAFile` per
document. The source name it reports ends in `.txt` on purpose: Jekyll picks its
converter from the source extension, so a `.txt` name leaves the Markdown body
unconverted, while the `permalink` decides the served path and output extension.

The gem namespaces each feature separately — `Jekyll::GeoKit::MarkdownAlternates`
under `lib/jekyll-geo-kit/markdown_alternates/` — so later GEO features sit
beside this one rather than inside it.

### Development

```sh
bundle install
bundle exec rake spec
```

The suite builds a fixture site in `spec/fixtures` and asserts on the generated
pages.
