class Ecm::Cms::Page < ActiveRecord::Base
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
                  :meta_description,
                  :pathname,
                  :title

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
  validates :title, :presence => true
end

