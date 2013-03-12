module Ecm
  module Cms
    module DatabaseI18nTemplate
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
        I18n.available_locales.each do |locale|
          base.validates "basename_#{locale}", :presence => true,
                                    :uniqueness =>  { :scope => [ "pathname_#{locale}", :format, :handler ] }
        end
        base.validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)
        base.validates :format, :inclusion => Mime::SET.symbols.map(&:to_s),
                                :allow_nil => true,
                                :allow_blank => true
        base.validates :pathname, :presence => true,
                                  :locales => :all
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
        filename << ".#{format}" if format.present?
        filename << ".#{handler}" if handler.present?
        filename
      end

      private

      def assert_trailing_slash_on_pathname
        self.class.locale_columns(:pathname) do |pn|
          # self.send("#{pn}=", '/') and return if self.send(pn).blank?
          self.send("#{pn}<<", '/') unless self.send(pn).end_with?('/')
        end
#        self.pathname = '/' and return if self.pathname.blank?
#        self.pathname << '/' unless self.pathname.end_with?('/')
      end

      def clear_resolver_cache
        Ecm::Cms::PageResolver.instance.clear_cache
      end

      def set_defaults
        if self.new_record?
          self.handler ||= Ecm::Cms::Configuration.default_handlers[:page].to_s
        end
      end
    end
  end
end

