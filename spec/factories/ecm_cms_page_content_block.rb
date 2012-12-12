FactoryGirl.define do
  factory :ecm_cms_page_content_block, :class => Ecm::Cms::Page::ContentBlock do
    body "Content block body"
    ecm_cms_content_box
    ecm_cms_page
  end
end
