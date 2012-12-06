module ActionView
  module TemplateRendererPatch
    def self.included base
      base.class_eval do
        alias_method :original_render, :render

        def render(context, options)
          @view = context
          @details = extract_details(options)
          extract_format(options[:file] || options[:template], @details)
          template = determine_template(options)
          context = @lookup_context

          unless context.rendered_format
            context.formats = template.formats unless template.formats.empty?
            context.rendered_format = context.formats.first
          end

          layout = template.layout if template.respond_to?(:layout)
          layout ||= options[:layout]

          render_template(template, layout, options[:locals])
        end
      end
    end
  end
end


ActionView::TemplateRenderer.send(:include, ActionView::TemplateRendererPatch)

