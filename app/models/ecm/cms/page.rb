module Ecm::Cms
  class Page < ActiveRecord::Base
    self.table_name = 'ecm_cms_pages'

    # add shared behaviour for database backed templates
    include DatabaseTemplate

    # associations
    has_many :ecm_cms_page_content_blocks,
             :class_name => 'Ecm::Cms::Page::ContentBlock',
             :dependent => :destroy,
             :foreign_key => 'ecm_cms_page_id'

    # attributes
    attr_accessible :basename,
                    :body,
                    :ecm_cms_folder_id,
                    :ecm_cms_navigation_item_ids,
                    :ecm_cms_page_content_blocks_attributes,
                    :format,
                    :handler,
                    :layout,
                    :locale,
                    :meta_description,
                    :pathname,
                    :title
    accepts_nested_attributes_for :ecm_cms_page_content_blocks, :allow_destroy => true

    # validations
    validates :title, :presence => true

    def home_page?
      return self.pathname == '/' && self.basename == 'home'
    end
  end
end

