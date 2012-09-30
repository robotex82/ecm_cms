class Ecm::Cms::Partial < ActiveRecord::Base
  # associations
  belongs_to :ecm_cms_folder,
             :class_name => 'Ecm::Cms::Folder',
             :foreign_key => 'ecm_cms_folder_id'

  # attributes
  attr_accessible :basename,
                  :body,
                  :format,
                  :handler,
                  :layout,
                  :locale,
                  :pathname

  # callbacks
  # TODO: add a underscore to the basename if not present
  after_initialize :set_defaults
  
  # validations
  validates :basename, :presence => true,
                       :uniqueness => { :scope => :ecm_cms_folder_id }
  validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)
  validates :locale, :inclusion => I18n.available_locales.map(&:to_s),
                     :allow_nil => true,
                     :allow_blank => true
  validates :format, :inclusion => Mime::SET.symbols.map(&:to_s),
                     :allow_nil => true,
                     :allow_blank => true
  validates :pathname, :presence => true

  private

  def set_defaults
    if self.new_record?
      self.locale  ||= I18n.default_locale.to_s
      self.handler ||= Ecm::Cms::Configuration.default_handlers[:partial].to_s
    end
  end
end

