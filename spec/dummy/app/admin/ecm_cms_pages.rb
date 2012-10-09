ActiveAdmin.register Ecm::Cms::Page do
  form do |f|
    f.inputs do
      f.input :title
      f.input :meta_description
      f.input :body
    end

    f.inputs do
      f.input :pathname
      f.input :basename
      f.input :locale
      f.input :format
      f.input :handler
    end

    f.actions
  end

  index do
    selectable_column
    column :pathname
    column :filename
    column :title
    column :layout
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    panel Ecm::Cms::Page.human_attribute_name(:body) do
      ecm_cms_page.body
    end
  end

  sidebar Ecm::Cms::Page.human_attribute_name(:details), :only => :show do
    attributes_table_for ecm_cms_page do
      # row :ecm_cms_navigation_item
      # row :folder
      row :pathname
      row :filename
      row :layout
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

