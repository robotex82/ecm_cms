FactoryGirl.define do
  factory :ecm_cms_template, :class => Ecm::Cms::Template do
    basename 'index'
    handler 'erb'
    pathname '/'
  end
end
