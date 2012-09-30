class Ecm::Cms::NavigationItem < ActiveRecord::Base
  # associations
  belongs_to :ecm_cms_navigation,
             :class_name => 'Ecm::Cms::Navigation',
             :foreign_key => 'ecm_cms_navigation_id'

  # attributes
  attr_accessible :depth,
                  :key,
                  :lft,
                  :name,
                  :options,
                  :rgt,
                  :string,
                  :url

  # validations
  validates :key, :presence => true
  validates :name, :presence => true
  validates :url, :presence => true
end
