source "https://rubygems.org"

gem "jekyll", "~> 4.4"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
end

# Not in the image (BUNDLE_WITHOUT in the Dockerfile).
group :deploy do
  gem "kamal", require: false
end
