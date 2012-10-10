FactoryGirl.define do
  factory :ecm_cms_navigation_item, :class => Ecm::Cms::NavigationItem do
    ecm_cms_navigation
    sequence(:name) { |i| "Navigation Item ##{i}" }
    key { name.dasherize }
    url '/'

    factory :ecm_cms_navigation_item_root do
      parent nil
    end

    factory :ecm_cms_navigation_item_child do
      association :parent, :factory => :ecm_cms_navigation_item
    end
  end
end
