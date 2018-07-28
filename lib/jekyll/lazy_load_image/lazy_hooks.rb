# frozen_string_literal: true

module Jekyll
  module LazyLoadImage
    module LazyHooks
      @load_hooks = Hash.new { |h, k| h[k] = [] }
      @loaded = Hash.new { |h, k| h[k] = [] }

      class << self
        def on_load(name, options = {}, &block)
          @loaded[name].each do |base|
            execute_hook(base, options, block)
          end

          @load_hooks[name] << [block, options]
        end

        def run_load_hooks(name, base = Object)
          @loaded[name] << base
          @load_hooks[name].each do |hook, options|
            execute_hook(base, options, hook)
          end
        end

        private

        def execute_hook(base, options, block)
          if options[:yield]
            block.call(base)
          else
            base.instance_eval(&block)
          end
        end
      end
    end
  end
end
