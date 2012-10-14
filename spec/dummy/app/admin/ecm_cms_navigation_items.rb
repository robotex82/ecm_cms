ActiveAdmin.register Ecm::Cms::NavigationItem do
  # Add member actions for positioning.
  sortable_tree_member_actions

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

  index :as => :nested_set do
    selectable_column
    sortable_tree_columns
    column :ecm_cms_navigation
    column :name
    column :url
    column :ecm_cms_page
    column :created_at
    column :updated_at
    default_actions
  end
end
