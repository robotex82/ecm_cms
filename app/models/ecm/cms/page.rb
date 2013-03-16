module Ecm::Cms
  class Page < ActiveRecord::Base
    self.table_name = 'ecm_cms_pages'

    # add shared behaviour for database backed templates
    include DatabaseTemplate

    # associations
    has_many :ecm_cms_navigation_items,
             :class_name => 'NavigationItem',
             :dependent => :nullify,
             :foreign_key => 'ecm_cms_page_id'
    has_many :ecm_cms_page_content_blocks,
             :class_name => 'Ecm::Cms::Page::ContentBlock',
             :dependent => :destroy,
             :foreign_key => 'ecm_cms_page_id',
             :inverse_of => :ecm_cms_page          

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

    # callbacks
    after_save :touch_navigation_items # , :if => Proc.new { |page| page.locale_changed? || page.pathname_changed? || page.basename_changed? }

    # validations
    validates :title, :presence => true

    def home_page? 
      return self.pathname == '/' && self.basename == 'home'
    end

    def touch_navigation_items
      self.ecm_cms_navigation_items.map(&:update_url_form_page!)
    end
  end
end
