require 'spec_helper'
require 'ecm/cms/importers/navigation_item'

module Ecm
  module Cms
    module Importers
      describe NavigationItem do
        it 'should read yaml' do
          yaml = <<YAML
- apple
- banana
- carrot
YAML
          importer = Ecm::Cms::Importers::NavigationItem.new(yaml)
          importer.yaml.should eq(['apple', 'banana', 'carrot'])
        end

        context 'with valid yaml' do
          before do
            @yaml = <<YAML
en:
  header:
    - name: Home
      url: /de/home
      key: home
    - name: Career
      url: /de/carreer
      key: carreer
    - name: Become partner
      url: /en/become-partner
      key: become-partner
    - name: Press
      url: /en/press
      key: press
    - name: News
      url: /en/news
      key: news
    - name: Contact
      url: /en/contact
      key: contact
YAML
          end

          it 'should recognize navigation item data' do
            importer = Ecm::Cms::Importers::NavigationItem.new(@yaml)
            importer.navigation_items.size.should eq(6)
          end

          it 'should build valid navigation items' do
            importer = Ecm::Cms::Importers::NavigationItem.new(@yaml)
            importer.navigation_items.first.should be_valid
          end
        end

        context 'with nested navigation items' do
          before do
            @yaml = <<YAML
en:
  main:
    - name: Our Product
      url: /en/unser-produkt
      key: our-product
      subitems:
        - name: Rewoo Scope
          url: /en/our-product
          key: our-product
        - name: Features
          url: /en/our-product/features
          key: our-product_features
        - name: Success Stories
          url: /en/our-product/success-stories
          key: our-product_success-stories
YAML
          end

          it 'should build nested items' do
            importer = Ecm::Cms::Importers::NavigationItem.new(@yaml)
            importer.navigation_items.first.children.count.should eq(3)
          end
        end
      end
    end
  end
end

