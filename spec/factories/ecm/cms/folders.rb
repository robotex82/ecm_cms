FactoryGirl.define do
  factory :ecm_cms_folder, :class => Ecm::Cms::Folder do
    pathname '/'
    basename 'foo'
  end
end
