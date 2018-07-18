# frozen_string_literal: true

module Jekyll
  module LazyLoadImage
    class Config
      class Ignore
        CONFIG_KEY = "ignore"

        def initialize(ignore_config)
          @ignore_config = ignore_config
        end

        def empty?
          @ignore_config.nil? || @ignore_config.empty?
        end

        def selector
          config_key = "selector"
          @ignore_config&.[](config_key).to_s.strip.tap do |s|
            raise "#{config_key} must be present." if s.empty?
          end
        end

        def selector_type
          @selector_type ||= SelectorType.new(@ignore_config&.[](SelectorType::CONFIG_KEY))
        end

        class SelectorType
          ALLOWED_SELECTOR_TYPE = %w(css xpath).freeze
          CONFIG_KEY = "selector_type"

          def initialize(selector_type)
            unless ALLOWED_SELECTOR_TYPE.include?(selector_type)
              message = "Ignore selector type must be #{ALLOWED_SELECTOR_TYPE.join(" or ")}. But passed #{selector_type}.}"
              raise ArgumentError, message
            end
            @selector_type = selector_type
          end

          def css?
            @selector_type == "css"
          end

          def xpath?
            @selector_type == "xpath"
          end
        end
      end
    end
  end
end
