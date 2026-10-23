# Changelog

## Unreleased

## 0.1.0

- Extracted from `rahendablog.github.io`'s `_plugins/md_alternates.rb`.
- Generates a Markdown alternate at `/<slug>.md` for every written document in
  the configured collections.
- Configurable through `markdown_alternates:` in `_config.yml`: `enabled`,
  `collections`, `index`, `extension`, `skip_key`, `authors_data`.
- Adds the `markdown_alternate_url` Liquid filter.
