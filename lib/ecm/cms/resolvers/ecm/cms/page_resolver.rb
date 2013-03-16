require 'ecm/cms/database_resolver'

module Ecm
  module Cms
    class PageResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      # add shared behaviour for database backed templates
      include Ecm::Cms::DatabaseResolver

      def build_source(record)
        output = ''
        record.ecm_cms_page_content_blocks.each do |content_block|
          # rendered_body = RedCloth.new(begin;content_block.body;end).to_html.html_safe
          rendered_body = RedCloth.new(content_block.body).to_html
          output << "<% content_for :#{content_block.content_box_name} do %>#{rendered_body}<% end %>"
        end

        content_for_title = "<% content_for :title do %>#{record.title}<% end %>"
        content_for_meta_description = "<% content_for :meta_description do %>#{record.meta_description}<% end %>"
        output << content_for_title << content_for_meta_description
        
        unless record.body.nil?
          output << record.body
        end

        return output
      end

      def normalize_basename(basename)
        basename
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

