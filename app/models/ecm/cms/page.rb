module Ecm::Cms
  class Page < ActiveRecord::Base
    self.table_name = 'ecm_cms_pages'

    # add shared behaviour for database backed templates
    include DatabaseI18nTemplate

    # associations
    has_many :ecm_cms_page_content_blocks,
             :class_name => 'Ecm::Cms::Page::ContentBlock',
             :dependent => :destroy,
             :foreign_key => 'ecm_cms_page_id'

    # attributes
    I18n.available_locales.each do |locale|
      attr_accessible "basename_#{locale}",
                      "body_#{locale}",
                      "meta_description_#{locale}",
                      "pathname_#{locale}",
                      "title_#{locale}"
    end

    attr_accessible :ecm_cms_folder_id,
                    :ecm_cms_navigation_item_ids,
                    :ecm_cms_page_content_blocks_attributes,
                    :format,
                    :handler,
                    :layout
    accepts_nested_attributes_for :ecm_cms_page_content_blocks, :allow_destroy => true

    # i18n
    translates :basename,
               :body,
               :meta_description,
               :pathname,
               :title

    # validations
    validates :title, :presence => true, :locales => :all

    def home_page?
      return self.pathname == '/' && self.basename == 'home'
    end
  end
end

