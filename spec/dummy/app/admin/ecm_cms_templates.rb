ActiveAdmin.register Ecm::Cms::Template do
  form do |f|
    f.inputs do
      f.input :body
    end

    f.inputs do
      f.input :pathname
      f.input :basename
      f.input :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
      f.input :format, :as => :select, :collection => Mime::SET.symbols.map(&:to_s)
      f.input :handler, :as => :select, :collection => ActionView::Template::Handlers.extensions.map(&:to_s)
    end

    f.actions
  end
end
