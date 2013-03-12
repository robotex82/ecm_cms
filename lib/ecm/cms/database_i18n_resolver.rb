module Ecm
  module Cms
    module DatabaseI18nResolver
      # Include hook for class methods
      def self.included(base)
        base.extend(ClassMethods)
      end

      # class methods go here
      module ClassMethods
      end

      # instance methods go here
      def find_templates(name, prefix, partial, details)
        return [] unless resolve(partial)

        pathname_column = "pathname_#{I18n.locale}".to_sym
        basename_column = "basename_#{I18n.locale}".to_sym 

        conditions = {
          pathname_column => assert_slashs(prefix.to_s),
          basename_column => normalize_basename(name),
          :format         => normalize_array(details[:formats]).first,
          :handler        => normalize_array(details[:handlers])
        }

        format = conditions.delete(:format)
        
        query  = self.template_class.constantize.where(conditions)

        # 2) Check for templates with the given format or format is nil
        query = query.where(["format = ? OR format = ''", format])

        # 3) Ensure templates with format come first
        query = query.order("format DESC")

        # 6) Now trigger the query passing on conditions to initialization
        query.map do |record|
          initialize_template(record, details)
        end
      end

      # Initialize an ActionView::Template object based on the record found.
      def initialize_template(record, details)
        source     = build_source(record)
        identifier = "#{record.class} - #{record.id} - #{record.pathname}#{record.basename}"
        handler    = ::ActionView::Template.registered_template_handler(record.handler)

        # 5) Check for the record.format, if none is given, try the template
        # handler format and fallback to the one given on conditions
        format   = record.format && Mime[record.format]
        format ||= handler.default_format if handler.respond_to?(:default_format)
        format ||= details[:formats]

        details = {
          :format => format,
          :updated_at => record.updated_at,
          :virtual_path => "#{record.pathname}#{record.basename}"
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

      # Normalize arrays by converting all symbols to strings.
      def normalize_array(array)
        array.map(&:to_s)
      end

      def build_source
        raise "call to abstract method #build_source"
      end

      def normalize_basename(basename)
        raise "call to abstract method #normalize_basename"
      end

      def resolve(partial_flag)
        raise "call to abstract method #resolve"
      end

      def template_class
        raise "call to abstract method #template_class"
      end
    end
  end
end

