ActiveAdmin.register Ecm::Cms::Partial do
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

  index do
    selectable_column
    column :pathname
    column :filename
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    panel Ecm::Cms::Partial.human_attribute_name(:body) do
      pre { ecm_cms_partial.body }
    end
  end

  sidebar Ecm::Cms::Partial.human_attribute_name(:details), :only => :show do
    attributes_table_for ecm_cms_partial do
      # row :folder
      row :pathname
      row :filename
      row :created_at
      row :updated_at
    end
  end # sidebar
end
