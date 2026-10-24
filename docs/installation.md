## Installation

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

That is all the setup the generator needs: build the site and every post in the
configured collections gets its `.md` alternate. To let crawlers discover them
through your HTML, add the `rel=alternate` snippet described under
[Usage](usage.md).

### GitHub Pages

jekyll-geo-kit is a third-party plugin, so GitHub's own Jekyll builder will not
run it. Build the site yourself in a workflow instead — either
`actions/jekyll-build-pages`, or `bundle exec jekyll build` followed by
`upload-pages-artifact` and `deploy-pages`.

GitHub Pages serves `.md` files as `text/markdown; charset=utf-8`, so the
alternates need no extra configuration once they are built.
