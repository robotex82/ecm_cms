FactoryGirl.define do
  factory :ecm_cms_navigation, :class => Ecm::Cms::Navigation do
    sequence(:name) { |i| "Navigation ##{i}" }
  end
end
