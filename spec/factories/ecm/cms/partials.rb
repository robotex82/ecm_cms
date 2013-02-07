FactoryGirl.define do
  factory :ecm_cms_partial, :class => Ecm::Cms::Partial do
    sequence(:basename) { |i| "_partial_#{i}" }
    handler 'erb'
    pathname '/'
  end
end
