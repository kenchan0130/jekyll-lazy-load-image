# Jekyll LazyLoadImage [![Build Status](https://travis-ci.org/kenchan0130/jekyll-lazy-load-image.svg?branch=master)](https://travis-ci.org/kenchan0130/jekyll-lazy-load-image)

_Edit img tag optimized lazy load images for your Jekyll site_

## Install

Add `gem 'jekyll-lazy-load-image'` to your site's `Gemfile` and run bundle.

## Usage

### `_config.yml`

Add the following to your site's `_config.yml`:

```yaml
lazy_load_image:
  src_attr_name: data-src # [required] You need to specify the attributes to be saved for lazy loading
  preload_image: /path/to/image # [optional] you can add a data uri or loading image as fallback src
  class_attr_values: # [optional] if you want to add custom class value, please add values
    - lazyload
  ignore_selectors: # [optional] if you want to ignore applying lazy load image, please add selector (css or xpath)
    - ".ignore-lazy-image-load"
    - "/*[@class='ignore-lazy-image-load']"
  additional_attrs: # [optional] if you want to add attributes, please add key value
    "data-size": auto 
```

### `_plugins`

Add the following to your site's `_plugins/lazy-load-image.rb`:

```ruby
Jekyll::LazyLoadImage.execute
```

#### Change container

If you want to change applying container, please add the following:

```ruby
Jekyll::LazyLoadImage.configure do |config|
  config.owners = %i[posts documents]
end

Jekyll::LazyLoadImage.execute
```

Default is `:posts` only.

See also: https://jekyllrb.com/docs/plugins/#hooks

### Select lazy load library

Select your favorite library and add your site. For example:
  - [lazysizes](https://github.com/aFarkas/lazysizes) [Recommend]
  - [Echo.js](https://github.com/toddmotto/echo)
  - [TADA](https://github.com/fallroot/tada)
  
## Development

- Use `bin/setup` to setup your local development environment.
- Use `bin/console` to load a local Pry console with the Gem.

## Testing

- `bundle exec rake spec`

## Contributing

1. Fork the project
2. Create a descriptively named feature branch
3. Add your feature
4. Submit a pull request
