class Ecm::Cms::NavigationItem < ActiveRecord::Base
  self.table_name = 'ecm_cms_navigation_items'

  # associations
  belongs_to :ecm_cms_navigation,
             :class_name => 'Ecm::Cms::Navigation',
             :foreign_key => 'ecm_cms_navigation_id'
  belongs_to :ecm_cms_page,
             :class_name => 'Ecm::Cms::Page',
             :foreign_key => 'ecm_cms_page_id'

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
  before_validation :update_url_form_page, :if => Proc.new { |ni| ni.ecm_cms_page.present? && ni.url.blank? }
  after_save :update_children_navigations!

  # default_scope
  default_scope :order => [:ecm_cms_navigation_id, :lft]

  # validations
  validates :key, :presence => true
  validates :name, :presence => true
  validates :url, :presence => true
  validates :ecm_cms_navigation, :presence => true, :if => :root?

  def params_for_new_page
    return {} if self.new_record?
    match = self.url.scan(/(#{I18n.available_locales.join('|')})$/)
    return { :locale => match[0][0], :pathname => '/', :basename => 'home', :title => self.name, :ecm_cms_navigation_item_ids => [ self.to_param ] } if match.size > 0
    match = self.url.scan(/(#{I18n.available_locales.join('|')})(.*)\/(.*)/)
    return {} unless match.first.respond_to?(:size) # && match.first.size != 3
    params = match.first
    return {} if params.size != 3
    params[1] << '/' unless params[1].end_with?('/')
    return { :locale => params[0], :pathname => params[1], :basename => params[2], :title => self.name, :ecm_cms_navigation_item_ids => [ self.to_param ] }
  end

  # @TODO: test
  def to_label
    if depth > 0
    "#{'&nbsp;' * depth} &#9654; #{name}".html_safe
    else
      name
    end
  end

  def update_navigation_from_parent!
    self.update_navigation_from_parent
    self.save!
  end

  def update_children_navigations!
    self.descendants.map(&:"update_navigation_from_parent!")
  end

  def update_url_form_page!
    # self.url = build_url_from_page(ecm_cms_page.locale, ecm_cms_page.pathname, ecm_cms_page.basename, ecm_cms_page.home_page?)
    update_url_form_page
    save!
  end

  private

  def build_url_from_page(locale, pathname, basename, is_home_page)
    if is_home_page
      "/#{locale}"
    else
      "/#{locale}#{pathname}#{basename}"
    end
  end

  def update_navigation_from_parent
    self.ecm_cms_navigation = self.parent.ecm_cms_navigation
  end

  def update_url_form_page
    self.url = build_url_from_page(ecm_cms_page.locale, ecm_cms_page.pathname, ecm_cms_page.basename, ecm_cms_page.home_page?)
  end
end

