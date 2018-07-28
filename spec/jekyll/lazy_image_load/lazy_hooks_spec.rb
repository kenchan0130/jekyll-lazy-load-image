# frozen_string_literal: true

RSpec.describe Jekyll::LazyLoadImage::LazyHooks do
  before do
    Jekyll::LazyLoadImage::LazyHooks.reset_load_hooks
    Jekyll::LazyLoadImage::LazyHooks.reset_loaded
  end

  describe ".on_load" do
    let(:load_key) { :load_test }

    it "should register a hook" do
      Jekyll::LazyLoadImage::LazyHooks.on_load(load_key) {}

      load_hooks = Jekyll::LazyLoadImage::LazyHooks.instance_variable_get(:@load_hooks)
      expect(load_hooks).to have_key(load_key)
    end
  end

  describe ".run_load_hooks" do
    let(:load_key) { :run_load_test }

    it "should run a registered hook" do
      incrementing_value = 0
      Jekyll::LazyLoadImage::LazyHooks.on_load(load_key) { incrementing_value =+ 1 }
      expect(incrementing_value).to eq(0)

      Jekyll::LazyLoadImage::LazyHooks.run_load_hooks(load_key)
      expect(incrementing_value).to eq(1)
    end
  end
end
