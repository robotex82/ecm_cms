module Ecm
  module Cms
    module Importers
      class Navigation
        def initialize(yaml, option = {})
          @navigations = nil
          @yaml = YAML.load(yaml)
        end

        def build_navigations
          navigations = []
          @yaml.each do |navigation_data|
            navigation = Ecm::Cms::Navigation.new(navigation_data)
            navigations << navigation
          end if @yaml.respond_to?(:each)
          navigations
        end

        def navigations
          @navigations ||= build_navigations
        end

        def yaml
          @yaml
        end
      end
    end
  end
end

