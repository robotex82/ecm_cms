class Ecm::Cms::Folder < ActiveRecord::Base
  # associations
  belongs_to :parent
  has_many :ecm_cms_pages,
           :class_name => 'Ecm::Cms::Page',
           :foreign_key => 'ecm_cms_folder_id'
  has_many :ecm_cms_partials,
           :class_name => 'Ecm::Cms::Partial',
           :foreign_key => 'ecm_cms_folder_id'
  has_many :ecm_cms_templates,
           :class_name => 'Ecm::Cms::Template',
           :foreign_key => 'ecm_cms_folder_id'

  # attributes
  attr_accessible :basename,
                  :children_count,
                  :depth,
                  :ecm_cms_templates_count,
                  :lft,
                  :pathname,
                  :rgt
end

