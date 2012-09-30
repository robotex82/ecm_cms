FactoryGirl.define do
  factory :ecm_cms_page, :class => Ecm::Cms::Page do
    basename 'home'
    handler 'erb'
    pathname '/'
    title 'Home'
  end
end
