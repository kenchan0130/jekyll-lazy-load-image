# frozen_string_literal: true

RSpec.describe Jekyll::LazyLoadImage do
  def load_hooks
    Jekyll::LazyLoadImage::LazyHooks.instance_variable_get(:@load_hooks)
  end

  let(:hook_key) { :jekyll_lazy_load_image }

  describe ".config" do
    subject { Jekyll::LazyLoadImage.config }

    it { is_expected.to be_a(Jekyll::LazyLoadImage::Config) }
  end

  describe ".execute" do
    it "should not raise error" do
      expect { Jekyll::LazyLoadImage.execute }.not_to raise_error
    end
  end

  describe ".register_hook" do
    before do
      Jekyll::LazyLoadImage::LazyHooks.reset_load_hooks
      Jekyll::LazyLoadImage::LazyHooks.reset_loaded
    end

    it "should register a hook of lazy load image" do
      expect(load_hooks).not_to have_key(hook_key)

      Jekyll::LazyLoadImage.register_hook

      expect(load_hooks).to have_key(hook_key)
    end
  end

  describe "Hook registration" do
    it "should already register a hook of lazy load image" do
      expect(load_hooks).to have_key(hook_key)
    end
  end
end
