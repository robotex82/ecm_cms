ActiveAdmin.register Ecm::Cms::Navigation do
  filter :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
  filter :name

  form do |f|
    f.inputs do
      f.input :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
      f.input :name
    end

    f.actions
  end

  index do
    selectable_column
    column :name
    column :locale    
    default_actions
  end

  show do
    panel Ecm::Cms::Navigation.human_attribute_name(:ecm_cms_navigation_items) do
      table_for ecm_cms_navigation.ecm_cms_navigation_items do
        column :name
        column :url
        column :ecm_cms_page
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
      row :locale
      row :name
      row :slug
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

