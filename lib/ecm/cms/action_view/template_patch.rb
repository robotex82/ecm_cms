module ActionView
  module TemplatePatch
    def self.included base
      base.class_eval do
        attr_accessor :layout

        alias_method :original_initialize, :initialize

        def initialize(source, identifier, handler, details)
          @layout = details[:layout] if details.has_key?(:layout)
          original_initialize(source, identifier, handler, details)
        end
      end
    end
  end
end

ActionView::Template.send(:include, ActionView::TemplatePatch)

