require 'ecm/cms/database_resolver'

module Ecm
  module Cms
    class TemplateResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      # add shared behaviour for database backed templates
      include Ecm::Cms::DatabaseResolver

      def template_class
        'Ecm::Cms::Template'
      end

      def build_source(record)
        record.body
      end
    end
  end
end

