class Ecm::Cms::Navigation < ActiveRecord::Base
  self.table_name = 'ecm_cms_navigations'

  # associations
  has_many :ecm_cms_navigation_items,
           :class_name => 'Ecm::Cms::NavigationItem',
           :dependent => :destroy,
           :foreign_key => 'ecm_cms_navigation_id'

  # attributes
  attr_accessible :name,
                  :slug

  # validations
  validates :name, :presence => true,
                   :uniqueness => true

  def to_s
    name
  end
end

