module Ecm
  module Cms
    module Importers
      class Page
        def initialize(yaml, option = {})
          @pages = nil
          @yaml = YAML.load(yaml)
        end

        def build_pages
          pages = []
          @yaml.each do |page_data|
            navigation_items = extract_navigation_items(page_data.delete('navigation_items'))
            page = Ecm::Cms::Page.new(page_data)
            page.ecm_cms_navigation_item_ids = navigation_items.map(&:id)
            pages << page
          end if @yaml.respond_to?(:each)
          pages
        end

        def extract_navigation_items(navigation_item_data)
          navigation_items = []
          navigation_item_data.each do |nid|
            navigation = Ecm::Cms::Navigation.where(:locale => nid['navigation_locale'], :name => nid['navigation_name']).first
            navigation_items << navigation.ecm_cms_navigation_items.where(:name => nid['name']).first if navigation.respond_to?(:ecm_cms_navigation_items)
          end
          navigation_items
        end

        def pages
          @pages ||= build_pages
        end

        def yaml
          @yaml
        end
      end
    end
  end
end

