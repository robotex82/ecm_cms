module Ecm::Cms
  class Page::ContentBlock < ActiveRecord::Base
    # associations
    belongs_to :ecm_cms_content_box, :class_name => 'ContentBox',
                                     :foreign_key => 'ecm_cms_content_box_id'
    belongs_to :ecm_cms_page, :class_name => 'Ecm::Cms::Page',
                              :foreign_key => 'ecm_cms_page_id'

    # attributes
    attr_accessible :body,
                    :ecm_cms_content_box_id

    # validations
    validates :body, :presence => true
    validates :ecm_cms_content_box, :presence => true
    validates :ecm_cms_page, :presence => true
    # validates :ecm_cms_page, :existence => true

    def content_box_name
      ecm_cms_content_box.name
    end
  end
end

