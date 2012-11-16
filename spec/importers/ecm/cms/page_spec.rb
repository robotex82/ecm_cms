require 'spec_helper'
require 'ecm/cms/importers/page'

module Ecm
  module Cms
    module Importers
      describe Page do
        it 'should read yaml' do
          yaml = <<YAML
      - apple
      - banana
      - carrot
YAML
          ypl = Ecm::Cms::Importers::Page.new(yaml)
          ypl.yaml.should eq(['apple', 'banana', 'carrot'])
        end

        context 'with valid yaml' do
          before do
            @yaml = <<YAML
      - title: Home
        locale: en
        meta_description: Rewoo home page
        body: |
          h1. Home [en]
        pathname: /
        basename: home
        handler: textile
        navigation_items:
          - navigation_locale: en
            navigation_name: main
            name: Home
YAML
          end


          it 'should recognize page data' do
            importer = Ecm::Cms::Importers::Page.new(@yaml)
            importer.pages.size.should eq(1)
          end

          it 'should build valid pages' do
            importer = Ecm::Cms::Importers::Page.new(@yaml)
            importer.pages.first.should be_valid
          end

          it 'should add navigation items' do
            n = FactoryGirl.create(:ecm_cms_navigation, :locale => 'en', :name => 'main')
            ni = FactoryGirl.create(:ecm_cms_navigation_item, :name => 'Home', :ecm_cms_navigation => n)
            importer = Ecm::Cms::Importers::Page.new(@yaml)
            importer.pages.first.ecm_cms_navigation_items.should eq([ni])
          end
        end
      end
    end
  end
end

