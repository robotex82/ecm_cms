class Ecm::Cms::Folder < ActiveRecord::Base
  self.table_name = 'ecm_cms_folders'
  
  # associations
  has_many :ecm_cms_pages,
           :class_name => 'Ecm::Cms::Page',
           :dependent => :destroy,
           :foreign_key => 'ecm_cms_folder_id'
  has_many :ecm_cms_partials,
           :class_name => 'Ecm::Cms::Partial',
           :dependent => :destroy,
           :foreign_key => 'ecm_cms_folder_id'
  has_many :ecm_cms_templates,
           :class_name => 'Ecm::Cms::Template',
           :dependent => :destroy,
           :foreign_key => 'ecm_cms_folder_id'

  # attributes
  attr_accessible :basename,
                  :children_count,
                  :depth,
                  :ecm_cms_templates_count,
                  :lft,
                  :pathname,
                  :rgt

  # validations
  validates :basename, :presence => true
  validates :pathname, :presence => true
end

