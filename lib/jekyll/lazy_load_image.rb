# frozen_string_literal: true

require "jekyll"
require "jekyll/lazy_load_image/config"
require "jekyll/lazy_load_image/site_config"
require "jekyll/lazy_load_image/lazy_hooks"
require "jekyll/lazy_load_image/translator"

module Jekyll
  module LazyLoadImage
    class << self
      def configure
        yield(config)
      end

      def config
        @config ||= Config.new
      end

      def execute
        Jekyll::LazyLoadImage::LazyHooks.run_load_hooks(hook_key)
      end

      def register_hook
        Jekyll::LazyLoadImage::LazyHooks.on_load(hook_key) do
          Jekyll::Hooks.register(config.owners, :post_render) do |post|
            site_config = Jekyll::LazyLoadImage::SiteConfig.new(
              post.site.config[Jekyll::LazyLoadImage::SiteConfig::CONFIG_KEY]
            )
            auto_lazy_load_image = Jekyll::LazyLoadImage::Translator.new(post.output, site_config)
            post.output = auto_lazy_load_image.translate
          end
        end
      end

      private

      def hook_key
        :jekyll_lazy_load_image
      end
    end
  end
end

Jekyll::LazyLoadImage.register_hook
