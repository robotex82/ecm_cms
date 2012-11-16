module Ecm
  module Cms
    module Importers
      class NavigationItem
        def initialize(yaml, option = {})
          @navigation_items = nil
          @yaml = YAML.load(yaml)
        end

        def create_navigation_items
          built_navigation_items = []
          @yaml.each do |navigation_locale, navigation|
            navigation.each do |navigation_name, navigation_items|
              n = find_or_create_navigation(navigation_locale, navigation_name)
              navigation_items.each do |navigation_item_attributes|
                ni = create_navigation_item(navigation_item_attributes, n)
                built_navigation_items << ni
              end
            end if navigation_locale.respond_to?(:each)
          end if @yaml.respond_to?(:each)
          built_navigation_items
        end

        def create_navigation_item(navigation_item_attributes, navigation)
          subitems = navigation_item_attributes.delete('subitems')

          ni = Ecm::Cms::NavigationItem.new(navigation_item_attributes)
          ni.ecm_cms_navigation = navigation
          ni.save!

          subitems.each do |subitem_attributes|
            subitem_attributes['parent'] = ni
            create_navigation_item(subitem_attributes, navigation)
          end if subitems.respond_to?(:each)

          ni
        end

        def find_or_create_navigation(navigation_locale, navigation_name)
          navigation = Ecm::Cms::Navigation.where(:locale => navigation_locale, :name => navigation_name).first
          navigation = Ecm::Cms::Navigation.create!(:locale => navigation_locale, :name => navigation_name) if navigation.nil?
          p navigation.inspect
          navigation
        end

        def navigation_items
          @navigation_items ||= create_navigation_items
        end

        def yaml
          @yaml
        end
      end
    end
  end
end

