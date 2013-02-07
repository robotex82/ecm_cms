FactoryGirl.define do
  factory :ecm_cms_page, :class => Ecm::Cms::Page do
    sequence(:basename) { |i| "page_#{i}" }
    handler 'erb'
    pathname '/'
    title 'Home'
  end
end
