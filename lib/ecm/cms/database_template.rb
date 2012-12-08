module Ecm
  module Cms
    module DatabaseTemplate
      # Include hook for class methods
      def self.included(base)
        base.extend(ClassMethods)

        # associations
        base.belongs_to :ecm_cms_folder,
                        :class_name => 'Ecm::Cms::Folder',
                        :foreign_key => 'ecm_cms_folder_id'

        # callbacks
        base.after_initialize :set_defaults
        base.before_validation :assert_trailing_slash_on_pathname
        base.after_save :clear_resolver_cache

        # validations
        # base.validates :basename, :presence => true,
        #                           :uniqueness => { :scope => [:ecm_cms_folder_id , :locale] }
        base.validates :basename, :presence => true,
                                  :uniqueness =>  { :scope => [ :pathname, :locale, :format, :handler ] }
        base.validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)
        base.validates :locale, :inclusion => I18n.available_locales.map(&:to_s),
                                :allow_nil => true,
                                :allow_blank => true
        base.validates :format, :inclusion => Mime::SET.symbols.map(&:to_s),
                                :allow_nil => true,
                                :allow_blank => true
        base.validates :pathname, :presence => true
      end

      # class methods go here
      module ClassMethods
#        def bar
#          puts 'class method'
#        end
      end

      # instance methods go here
      def filename
        filename = basename.dup
        filename << ".#{locale}" if locale.present?
        filename << ".#{format}" if format.present?
        filename << ".#{handler}" if handler.present?
        filename
      end

      private

      def assert_trailing_slash_on_pathname
        self.pathname = '/' and return if self.pathname.blank?
        self.pathname << '/' unless self.pathname.end_with?('/')
      end

      def clear_resolver_cache
        Ecm::Cms::PageResolver.instance.clear_cache
      end

      def set_defaults
        if self.new_record?
          self.locale  ||= I18n.default_locale.to_s
          self.handler ||= Ecm::Cms::Configuration.default_handlers[:page].to_s
        end
      end
    end
  end
end

