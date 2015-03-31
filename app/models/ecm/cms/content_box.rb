module Ecm::Cms
  class ContentBox < ActiveRecord::Base
    self.table_name = 'ecm_cms_content_boxes'

    # associations
    has_many :ecm_cms_page_content_blocks, :class_name => 'Page::ContentBlock',
                                           :foreign_key => 'ecm_cms_content_box_id'

    # attributes
    attr_accessible(:name) if Rails.version < '4.0.0'

    # validations
    validates :name, :presence => true,
                     :uniqueness => true

    def ecm_cms_page_content_blocks_count
      ecm_cms_page_content_blocks.count
    end
  end
end

