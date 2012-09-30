FactoryGirl.define do
  factory :ecm_cms_partial, :class => Ecm::Cms::Partial do
    basename '_sidebar'
    handler 'erb'
    pathname '/'
  end
end
