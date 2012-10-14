require 'ecm/cms/database_resolver'

module Ecm
  module Cms
    class PartialResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      # add shared behaviour for database backed templates
      include Ecm::Cms::DatabaseResolver

      def template_class
        'Ecm::Cms::Partial'
      end

      def build_source(record)
        record.body
      end

      def resolve(partial_flag)
        partial_flag
      end
    end
  end
end

