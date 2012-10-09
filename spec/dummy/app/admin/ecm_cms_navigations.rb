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
    panel Ecm::Cms::Navigation.human_attribute_name(:navigation_items) do
      para '@TODO'
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

