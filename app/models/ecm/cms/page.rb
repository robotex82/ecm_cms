class Ecm::Cms::Page < ActiveRecord::Base
  self.table_name = 'ecm_cms_pages'

  # associations
  belongs_to :ecm_cms_folder,
             :class_name => 'Ecm::Cms::Folder',
             :foreign_key => 'ecm_cms_folder_id'
  has_many :ecm_cms_navigation_items,
           :class_name => 'Ecm::Cms::NavigationItem',
           :dependent => :nullify,
           :foreign_key => 'ecm_cms_page_id'

  # attributes
  attr_accessible :basename,
                  :body,
                  :ecm_cms_folder_id,
                  :ecm_cms_navigation_item_ids,
                  :format,
                  :handler,
                  :layout,
                  :locale,
                  :meta_description,
                  :pathname,
                  :title

  # callbacks
  after_initialize :set_defaults
  before_validation :assert_trailing_slash_on_pathname
  after_save :clear_resolver_cache
  after_save :touch_navigation_items # , :if => Proc.new { |page| page.locale_changed? || page.pathname_changed? || page.basename_changed? }

  # validations
  validates :basename, :presence => true,
                       :uniqueness => { :scope => [:ecm_cms_folder_id , :locale] }
  validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)
  validates :locale, :inclusion => I18n.available_locales.map(&:to_s),
                     :allow_nil => true,
                     :allow_blank => true
  validates :format, :inclusion => Mime::SET.symbols.map(&:to_s),
                     :allow_nil => true,
                     :allow_blank => true
  validates :pathname, :presence => true
  validates :title, :presence => true

  def filename
    filename = basename
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

  def touch_navigation_items
    self.ecm_cms_navigation_items.map(&:update_url_form_page!)
  end
end

