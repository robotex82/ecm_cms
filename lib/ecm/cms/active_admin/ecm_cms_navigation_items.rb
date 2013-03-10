ActiveAdmin.register Ecm::Cms::NavigationItem do
  # Add member actions for positioning.
  sortable_tree_member_actions

  # Menu
  menu :parent => Proc.new { I18n.t('ecm.cms.active_admin.menu') }.call

  form do |f|
    f.inputs do
      f.input :ecm_cms_navigation, :collection => Ecm::Cms::Navigation.all.collect { |navigation| [navigation.to_s, navigation.id] }
      f.input :parent
    end

    f.translate_inputs do |ti|
      f.inputs do
        ti.input :name
        ti.input :url
      end # f.inputs
    end # f.translate_inputs

    f.inputs do
      f.input :key
      f.input :options
    end

    f.actions
  end

  index :as => :nested_set do
    selectable_column
    sortable_tree_columns
    column(:ecm_cms_navigation) { |ni| link_to(ni.ecm_cms_navigation.to_s, [:admin, ni.ecm_cms_navigation]) }
    column :name
    column :url
    column :created_at
    column :updated_at
    default_actions
  end
end

