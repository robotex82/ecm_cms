class Ecm::Cms::Navigation < ActiveRecord::Base
  self.table_name = 'ecm_cms_navigations'

  # associations
  has_many :ecm_cms_navigation_items,
           :class_name => 'Ecm::Cms::NavigationItem',
           :dependent => :destroy,
           :foreign_key => 'ecm_cms_navigation_id'

  # attributes
  attr_accessible :locale,
                  :name,
                  :slug

  # validations
  validates :locale, :inclusion => I18n.available_locales.map(&:to_s),
                     :allow_nil => true
  validates :name, :presence => true,
                   :uniqueness => { :scope => [ :locale ] }

  def to_s
    "#{self.name} (#{self.locale})"
  end
end

