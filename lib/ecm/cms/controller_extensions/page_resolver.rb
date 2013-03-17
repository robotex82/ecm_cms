module Ecm
  module Cms
    module ControllerExtensions
      module PageResolver
        def self.included(base)
          # add the page resolver
          base.prepend_view_path ::Ecm::Cms::PageResolver.instance unless base.view_paths.include?(::Ecm::Cms::PageResolver.instance)
        end
      end
    end
  end
end

