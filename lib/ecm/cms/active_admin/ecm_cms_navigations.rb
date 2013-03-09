include ActiveAdmin::AwesomeNestedSet::Helper

ActiveAdmin.register Ecm::Cms::Navigation do
  # Filters
  filter :name

  # Menu
  menu :parent => Proc.new { I18n.t('ecm.cms.active_admin.menu') }.call

  form do |f|
    f.inputs do
      f.input :name
    end

    f.actions
  end

  index do
    selectable_column
    column :name
    default_actions
  end

  show do
    panel Ecm::Cms::Navigation.human_attribute_name(:ecm_cms_navigation_items) do
      table_for ecm_cms_navigation.ecm_cms_navigation_items, :i18n => Ecm::Cms::NavigationItem do
        sortable_tree_columns
        column :name
        column :url
        column :ecm_cms_page do |ni|
          if ni.ecm_cms_page.blank?
            link_to(I18n.t('active_admin.create_model', :model => Ecm::Cms::Page.model_name.human), new_admin_ecm_cms_page_path({:ecm_cms_page => ni.params_for_new_page}))
          else
            link_to(ni.ecm_cms_page.title, [:admin, ni.ecm_cms_page])
          end
        end
        column :created_at
        column :updated_at

        column do |ni|
          link_to(I18n.t('active_admin.view'), [:admin, ni], :class => "member_link view_link") +
          link_to(I18n.t('active_admin.edit'), [:edit, :admin, ni], :class => "member_link edit_link")
        end
      end
    end
  end

  sidebar Ecm::Cms::Navigation.human_attribute_name(:details), :only => :show do
    attributes_table_for ecm_cms_navigation do
      row :name
      row :slug
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

