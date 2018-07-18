# frozen_string_literal: true

require "nokogiri"

module Jekyll
  module LazyLoadImage
    class Translator
      def initialize(document, config)
        @document = document
        @config = config
      end

      def translate
        nokogiri_doc.xpath("//img").each do |node|
          next if ignore_node?(node)
          apply_lazy_image_setting(node)
          inject_class_attr(node)
          inject_additional_attrs(node)
        end
        nokogiri_doc.to_html
      end

      private

      def ignore_node?(node)
        return false if config.ignore.empty?

        found_node_size = if config.ignore.selector_type.css?
                            node.css(config.ignore.selector).size
                          elsif config.ignore.selector_type.xpath?
                            node.xpath(config.ignore.selector).size
                          else
                            raise "There may be a change in specifications in ignore selector type."
                          end

        found_node_size.positive?
      end

      def apply_lazy_image_setting(node)
        node_src_attr = node.attributes["src"]
        return if node_src_attr.nil?

        src_value = node_src_attr.value
        if config.preload_image.empty?
          node.remove_attribute("src")
        else
          node.attributes["src"].value = config.preload_image
        end

        node.set_attribute(config.src_attr_name, src_value)
      end

      def inject_class_attr(node)
        class_value = node.attributes["class"]&.value
        return if class_value.nil? && config.class_attr_values.empty?

        node.set_attribute("class", "") if class_value.nil?
        node_class_attr = node.attributes["class"]
        class_array_option = [node_class_attr.value, config.class_attr_values].flatten
        class_array = class_array_option.reject do |class_name|
          class_name.nil? || class_name.empty?
        end
        node_class_attr.value = class_array.join(" ")
      end

      def inject_additional_attrs(node)
        config.additional_attrs.each do |key, value|
          node.set_attribute(key, value)
        end
      end

      def nokogiri_doc
        @nokogiri_doc ||= Nokogiri::HTML(@document)
      end
    end
  end
end
