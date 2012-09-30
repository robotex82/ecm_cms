class Ecm::Cms::Navigation < ActiveRecord::Base
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
                     :if => Proc.new { |n| n.locale.present? }
  validates :name, :presence => true,
                   :uniqueness => { :scope => [ :locale ] }
end
