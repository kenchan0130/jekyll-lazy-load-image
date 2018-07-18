# frozen_string_literal: true

require "jekyll"
require "jekyll/lazy-load-image/config"
require "jekyll/lazy-load-image/translator"
require "jekyll/lazy-load-image/version"

module Jekyll
  module LazyLoadImage
  end
end

Jekyll::Hooks.register :posts, :post_render do |post|
  config = Jekyll::LazyLoadImage::Config.new(
    post.site.config[Jekyll::LazyLoadImage::Config::SITE_CONFIG_KEY]
  )
  auto_lazy_load_image = Jekyll::LazyLoadImage::Translator.new(post.output, config)
  post.output = auto_lazy_load_image.translate
end
