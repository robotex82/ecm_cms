FactoryGirl.define do
  factory :ecm_cms_template, :class => Ecm::Cms::Template do
    sequence(:basename) { |i| "template_#{i}" }
    handler 'erb'
    pathname '/'
  end
end
