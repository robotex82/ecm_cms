module Ecm
  module Cms
    module ControllerExtensions
      module TemplateResolver
        def self.included(base)
          # add the template resolver
          base.prepend_view_path ::Ecm::Cms::TemplateResolver.instance unless base.view_paths.include?(::Ecm::Cms::TemplateResolver.instance)
        end
      end
    end
  end
end

