require 'ecm/cms/database_resolver'

module Ecm
  module Cms
    class TemplateResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      # add shared behaviour for database backed templates
      include Ecm::Cms::DatabaseResolver

      def build_source(record)
        record.body
      end

      def normalize_basename(basename)
        basename
      end

      def resolve(partial_flag)
        !partial_flag
      end

      def template_class
        'Ecm::Cms::Template'
      end
    end
  end
end

