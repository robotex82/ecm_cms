require 'ecm/cms/database_resolver'

module Ecm
  module Cms
    class PageResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      # add shared behaviour for database backed templates
      include Ecm::Cms::DatabaseResolver

      def build_source(record)
        if record.body.nil?
          source = '' 
        else
          source = record.body
        end
        content_for_title = "<% content_for :title do %>#{Ecm::Cms::Configuration.site_title} - #{record.title}<% end %>"
        content_for_meta_description = "<% content_for :meta_description do %>#{record.meta_description}<% end %>"
        source << content_for_title << content_for_meta_description
      end

      def resolve(partial_flag)
        !partial_flag
      end

      def template_class
        'Ecm::Cms::Page'
      end
    end
  end
end

