require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Ecm
  module Cms
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :default_handlers
      @@default_handlers = {}
      def default_handlers=(default_handlers)
        @@default_handlers = HashWithIndifferentAccess.new(default_handlers)
      end

      mattr_accessor :site_title
      @@site_title = ''
    end
  end
end
