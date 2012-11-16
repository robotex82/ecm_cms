require 'spec_helper'
require 'ecm/cms/importers/navigation'

module Ecm
  module Cms
    module Importers
      describe Navigation do
        it 'should read yaml' do
          yaml = <<YAML
      - apple
      - banana
      - carrot
YAML
          importer = Ecm::Cms::Importers::Navigation.new(yaml)
          importer.yaml.should eq(['apple', 'banana', 'carrot'])
        end

        context 'with valid yaml' do
          before do
            @yaml = <<YAML
      - locale: en
        name: header
      - locale: en
        name: legal
      - locale: en
        name: main
YAML
          end


          it 'should recognize navigation data' do
            importer = Ecm::Cms::Importers::Navigation.new(@yaml)
            importer.navigations.size.should eq(3)
          end

          it 'should build valid navigations' do
            importer = Ecm::Cms::Importers::Navigation.new(@yaml)
            importer.navigations.first.should be_valid
          end
        end
      end
    end
  end
end

