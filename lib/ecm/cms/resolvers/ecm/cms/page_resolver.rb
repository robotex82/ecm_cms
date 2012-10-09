module Ecm
  module Cms
    class PageResolver < ActionView::Resolver
      require 'singleton'
      include Singleton

      def find_templates(name, prefix, partial, details)
        return [] if partial

        conditions = {
#          :pathname    => normalize_path(name, prefix),
          :pathname    => prefix + '/',
          :basename    => name,
          :locale      => normalize_array(details[:locale]).first,
          :format      => normalize_array(details[:formats]).first,
          :handler     => normalize_array(details[:handlers])
        }
p conditions.inspect
        format = conditions.delete(:format)
        query  = Ecm::Cms::Page.where(conditions)

        # 2) Check for templates with the given format or format is nil
        query = query.where(["format = ? OR format = ''", format])

        # 3) Ensure templates with format come first
        query = query.order("format DESC")

        # 4) Now trigger the query passing on conditions to initialization
        query.map do |record|
          initialize_template(record, details)
        end
      end

      # Initialize an ActionView::Template object based on the record found.
      def initialize_template(record, details)
        source     = record.body
        identifier = "Page - #{record.id} - #{record.pathname.inspect}"
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

        ::ActionView::Template.new(source, identifier, handler, details)
      end

      # Normalize name and prefix, so the tuple ["index", "users"] becomes
      # "users/index" and the tuple ["template", nil] becomes "template".
      def normalize_path(name, prefix)
        prefix.present? ? "#{prefix}/#{name}" : name
      end

      # Normalize arrays by converting all symbols to strings.
      def normalize_array(array)
        array.map(&:to_s)
      end
    end
  end
end

