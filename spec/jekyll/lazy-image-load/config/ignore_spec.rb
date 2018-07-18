# frozen_string_literal: true

RSpec.describe Jekyll::LazyLoadImage::Config::Ignore do
  subject(:ignore_config) { Jekyll::LazyLoadImage::Config::Ignore.new(ignore_config_param) }

  describe "#empty?" do
    subject { ignore_config.empty? }

    context "when the ignore config is nil" do
      let(:ignore_config_param) { nil }

      it { is_expected.to be true }
    end

    context "when the ignore config is empty hash" do
      let(:ignore_config_param) { {} }

      it { is_expected.to be true }
    end

    context "when the ignore config is present" do
      let(:ignore_config_param) do
        {
          "selector" => ".ignore-lazyload",
          "selector_type" => "css",
        }
      end

      it { is_expected.to be false }
    end
  end

  describe "#selector" do
    subject { ignore_config.selector }

    context "without the 'selector' config key" do
      let(:ignore_config) do
        {
          "selector_type" => "css",
        }
      end

      it "should raise error" do
        expect { ignore_config.selector }.to raise_error StandardError
      end
    end

    context "with the 'selector' config key" do
      let(:ignore_config_param) do
        {
          "selector" => "/@ignore-lazyload",
          "selector_type" => "xpath",
        }
      end

      it { is_expected.to be_truthy }
    end
  end

  describe "#selector_type" do
    subject { ignore_config.selector_type }

    let(:ignore_config_param) do
      {
        "selector" => "/@ignore-lazyload",
        "selector_type" => "xpath",
      }
    end

    it { is_expected.to be_a Jekyll::LazyLoadImage::Config::Ignore::SelectorType }
  end
end

RSpec.describe Jekyll::LazyLoadImage::Config::Ignore::SelectorType do
  subject(:selector_type) do
    Jekyll::LazyLoadImage::Config::Ignore::SelectorType.new(selector_type_param)
  end

  describe ".new" do
    context "with invalid selector type" do
      let(:selector_type_param) { "invalid-type" }

      it "should raise error" do
        expect do
          Jekyll::LazyLoadImage::Config::Ignore::SelectorType.new(selector_type_param)
        end.to raise_error ArgumentError
      end
    end
  end

  describe "#css?" do
    subject { selector_type.css? }

    context "when the selector type is 'css'" do
      let(:selector_type_param) { "css" }

      it { is_expected.to be true }
    end

    context "when the selector type is not 'css'" do
      let(:selector_type_param) { "xpath" }

      it { is_expected.to be false }
    end
  end

  describe "#xpath?" do
    subject { selector_type.xpath? }

    context "when the selector type is 'xpath'" do
      let(:selector_type_param) { "xpath" }

      it { is_expected.to be true }
    end

    context "when the selector type is not 'xpath'" do
      let(:selector_type_param) { "css" }

      it { is_expected.to be false }
    end
  end
end
