# frozen_string_literal: true

module Jekyll
  module LazyLoadImage
    module LazyHooks
      class << self
        def reset_load_hooks
          @load_hooks = default_hash
        end

        def reset_loaded
          @loaded = default_hash
        end

        private

        def default_hash
          Hash.new { |h, k| h[k] = [] }
        end
      end
    end
  end
end
