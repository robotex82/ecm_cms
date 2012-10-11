ActiveAdmin.register Ecm::Cms::NavigationItem do
  form do |f|
    f.inputs do
      f.input :ecm_cms_navigation
      f.input :parent
      f.input :name      
    end

    f.inputs do
      f.input :ecm_cms_page
      f.input :url
    end

    f.inputs do
      f.input :key
      f.input :options
    end

    f.actions
  end

  index do
    selectable_column
    column :name
    column :url
    column :ecm_cms_page
    column :created_at
    column :updated_at
    default_actions
  end
end
