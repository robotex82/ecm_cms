module ActionView::Template::Handlers
  class Textile

    class_attribute :default_format
    self.default_format = Mime::HTML

    def erb_handler
      @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template)
      compiled_source = erb_handler.call(template)
      "RedCloth.new(begin;#{compiled_source};end).to_html.html_safe"
    end

  end
end

