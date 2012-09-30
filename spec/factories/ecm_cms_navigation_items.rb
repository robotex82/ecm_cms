FactoryGirl.define do
  factory :ecm_cms_navigation_item, :class => Ecm::Cms::NavigationItem do
    sequence(:name) { |i| "Navigation Item ##{i}" }
    key { name.dasherize }
    url '/'
  end
end
