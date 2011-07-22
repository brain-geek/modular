module Modular
  module Components
    module Caching
      def self.included(base)
        base.cattr_accessor :cache_options
        
        base.class_eval do
          def self.cache(*args, &block)
            self.cache_options = args.extract_options!
            self.cache_options[:cache_key] = block if block_given?
          end
        end
      end
      
      def render
        if cache_options.nil?
          super
        elsif cached?
          get_cached
        else
          data = super
          do_caching data
          data
        end
      end

      def cache_store
        ::ActionController::Base.cache_store
      end
      
      def cache_options
        self.class.cache_options
      end
      
      def clear_cache
        cache_store.delete cache_key
      end
      
      protected
      def cache_key
        key = cache_options[:cache_key]
        key = key.call(self) if key.is_a? Proc
        key = self.to_json if key.nil?
        
        ::ActiveSupport::Cache.expand_cache_key key, :modular
      end
      
      def cached?
        cache_store.exist? cache_key
      end
      
      def get_cached
        cache_store.read cache_key
      end
      
      def do_caching(data)
        cache_store.write cache_key, data, cache_options
      end

    end
  end
end