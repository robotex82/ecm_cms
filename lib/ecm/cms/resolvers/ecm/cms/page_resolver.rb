module Ecm
  module Cms
    class PageResolver < ActionView::Resolver
      require 'singleton'
      include Singleton

      def find_templates(name, prefix, partial, details)
        return []
      end
    end
  end
end

