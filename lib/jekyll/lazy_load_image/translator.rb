# frozen_string_literal: true

require "nokogiri"

module Jekyll
  module LazyLoadImage
    class Translator
      def initialize(document, site_config)
        @document = document
        @site_config = site_config
      end

      def translate
        nokogiri_doc.xpath("//img").each do |node|
          next if ignore_node?(node)
          apply_lazy_image_setting(node)
          inject_class_attr(node)
          inject_additional_attrs(node)
        end
        nokogiri_doc.to_html.gsub(/[\r\n]/, "")
      end

      private

      def ignore_node?(node)
        !@site_config.ignore_selectors.empty? && node.matches?(*@site_config.ignore_selectors)
      end

      def apply_lazy_image_setting(node)
        node_src_attr = node.attributes["src"]
        return if node_src_attr.nil?

        src_value = node_src_attr.value
        if @site_config.preload_image.empty?
          node.remove_attribute("src")
        else
          node.attributes["src"].value = @site_config.preload_image
        end

        node.set_attribute(@site_config.src_attr_name, src_value)
      end

      def inject_class_attr(node)
        class_value = node.attributes["class"]&.value
        return if class_value.nil? && @site_config.class_attr_values.empty?

        node.set_attribute("class", "") if class_value.nil?
        node_class_attr = node.attributes["class"]
        class_array_option = [node_class_attr.value, @site_config.class_attr_values].flatten
        class_array = class_array_option.reject do |class_name|
          class_name.nil? || class_name.empty?
        end

        node_class_attr.value = normalize_class_array(class_array)
      end

      def inject_additional_attrs(node)
        @site_config.additional_attrs.each do |key, value|
          node.set_attribute(key, value)
        end
      end

      def nokogiri_doc
        @nokogiri_doc ||= Nokogiri::HTML(@document)
      end

      def normalize_class_array(array)
        array.map(&:strip).uniq.join(" ")
      end
    end
  end
end