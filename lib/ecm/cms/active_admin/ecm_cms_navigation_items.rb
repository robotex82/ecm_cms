ActiveAdmin.register Ecm::Cms::NavigationItem do
  permit_params(:depth,
                :ecm_cms_navigation_id,
                :ecm_cms_page_id,
                :id,
                :key,
                :name,
                :options,
                :parent_id,
                :string,
                :url) if Rails.version >= '4.0.0'

  sortable_tree_member_actions

  # Menu
  menu :parent => Proc.new { I18n.t('ecm.cms.active_admin.menu') }.call

  form do |f|
    f.inputs do
      f.input :ecm_cms_navigation, :collection => Ecm::Cms::Navigation.all.collect { |navigation| [navigation.to_s, navigation.id] }
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
    column(:ecm_cms_navigation) { |ni| link_to(ni.ecm_cms_navigation.to_s, [:admin, ni.ecm_cms_navigation]) }
    sortable_tree_indented_column :name
    column :url
    column :ecm_cms_page do |ni|
      if ni.ecm_cms_page.blank?
        link_to(I18n.t('active_admin.new_model', :model => Ecm::Cms::Page.model_name.human), new_admin_ecm_cms_page_path({:ecm_cms_page => ni.params_for_new_page}))
      else
        link_to(ni.ecm_cms_page.title, [:admin, ni.ecm_cms_page])
      end
    end
    column :created_at
    column :updated_at
    ActiveAdmin::VERSION[0] < '1' ? default_actions : actions
  end
end
