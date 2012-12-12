FactoryGirl.define do
  factory :ecm_cms_content_box, :class => Ecm::Cms::ContentBox do
    sequence(:name) { |i| "ContentBox ##{i}" }
  end
end
