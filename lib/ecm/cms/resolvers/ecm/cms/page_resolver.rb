module Ecm
  module Cms
    class PageResolver < ::ActionView::Resolver
      require 'singleton'
      include Singleton

      def find_templates(name, prefix, partial, details)
        return [] if partial

        conditions = {
          :pathname    => assert_slashs(prefix),
          :basename    => name,
          :locale      => normalize_array(details[:locale]).first,
          :format      => normalize_array(details[:formats]).first,
          :handler     => normalize_array(details[:handlers])
        }

        format = conditions.delete(:format)
        locale = conditions.delete(:locale)
        
        query  = Ecm::Cms::Page.where(conditions)

        # 2) Check for templates with the given format or format is nil
        query = query.where(["format = ? OR format = ''", format])

        # 3) Ensure templates with format come first
        query = query.order("format DESC")

        # 4) Check for templates with the given locale or locale is nil
        query = query.where(["locale = ? OR locale = ''", locale])

        # 5) Ensure templates with locale come first
        query = query.order("locale DESC")

        # 6) Now trigger the query passing on conditions to initialization
        query.map do |record|
          initialize_template(record, details)
        end
      end

      # Initialize an ActionView::Template object based on the record found.
      def initialize_template(record, details)
        # source     = record.body
        source     = build_source(record.body, record.title, record.meta_description)
        identifier = "Page - #{record.id} - #{record.pathname}#{record.filename}"
        handler    = ::ActionView::Template.registered_template_handler(record.handler)

        # 5) Check for the record.format, if none is given, try the template
        # handler format and fallback to the one given on conditions
        format   = record.format && Mime[record.format]
        format ||= handler.default_format if handler.respond_to?(:default_format)
        format ||= details[:formats]

        details = {
          :format => format,
          :updated_at => record.updated_at,
          #:virtual_path => virtual_path(record.pathname, record.partial)
          :virtual_path => record.pathname
        }

        details[:layout] = record.layout if record.layout.present?

        ::ActionView::Template.new(source, identifier, handler, details)
      end

      def assert_slashs(prefix)
        output = prefix.dup
        output << '/' unless output.end_with?('/')
        output = '/' << output unless output.start_with?('/')
        return output
      end

#      # Normalize name and prefix, so the tuple ["index", "users"] becomes
#      # "users/index" and the tuple ["template", nil] becomes "template".
#      def normalize_path(name, prefix)
#        prefix.present? ? "#{prefix}/#{name}" : name
#      end

      # Normalize arrays by converting all symbols to strings.
      def normalize_array(array)
        array.map(&:to_s)
      end

      def build_source(body, title, meta_description)
        body = '' if body.nil?
        content_for_title = "<% content_for :title do %>#{Ecm::Cms::Configuration.site_title} - #{title}<% end %>"
        content_for_meta_description = "<% content_for :meta_description do %>#{meta_description}<% end %>"
        body << content_for_title << content_for_meta_description
      end
    end
  end
end

