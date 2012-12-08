module Ecm
  module Cms
    module ControllerExtensions
      module PartialResolver
        def self.included(base)
          # add the partial resolver
          base.append_view_path ::Ecm::Cms::PartialResolver.instance unless base.view_paths.include?(::Ecm::Cms::PartialResolver.instance)
        end
      end
    end
  end
end

