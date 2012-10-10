class Ecm::Cms::NavigationItem < ActiveRecord::Base
  self.table_name = 'ecm_cms_navigation_items'

  # associations
  belongs_to :ecm_cms_navigation,
             :class_name => 'Ecm::Cms::Navigation',
             :foreign_key => 'ecm_cms_navigation_id'

  # attributes
  attr_accessible :depth,
                  :key,
#                  :lft,
                  :name,
                  :options,
#                  :rgt,
                  :string,
                  :url
  attr_protected :lgt,
                 :rgt

  # awesome nested set
  acts_as_nested_set :dependent => :destroy, :counter_cache => :children_count, :scope => :ecm_cms_navigation_id

  # callbacks
  before_validation :update_navigation_from_parent, :if => Proc.new { |ni| ni.child? }
  after_save :update_children_navigations!

  # default_scope
  default_scope :order => [:ecm_cms_navigation_id, :lft]

  # validations
  validates :key, :presence => true
  validates :name, :presence => true
  validates :url, :presence => true
  validates :ecm_cms_navigation, :presence => true, :if => :root?

  def update_navigation_from_parent!
p 'update_navigation_from_parent!'
    self.update_navigation_from_parent
    self.save!
  end

  def update_children_navigations!
p 'update_children_navigations!'
p self.descendants.inspect
    self.descendants.map(&:"update_navigation_from_parent!")
  end

  private

  def update_navigation_from_parent
    self.ecm_cms_navigation = self.parent.ecm_cms_navigation
  end
end

