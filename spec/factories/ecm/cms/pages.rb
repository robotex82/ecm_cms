FactoryGirl.define do
  factory :ecm_cms_page, :class => Ecm::Cms::Page do
    pathname_en '/'
    sequence(:basename_en) { |i| "page_#{i}" }
    title_en 'Page'
    pathname_de '/'
    sequence(:basename_de) { |i| "page_#{i}" }
    title_de 'Seite'
    handler 'erb'
  end
end

