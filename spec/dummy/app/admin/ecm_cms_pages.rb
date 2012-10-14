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
      f.input :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
      f.input :format, :as => :select, :collection => Mime::SET.symbols.map(&:to_s)
      f.input :handler, :as => :select, :collection => ActionView::Template::Handlers.extensions.map(&:to_s)
    end

    f.inputs do
      f.input :layout
    end

    I18n.available_locales.each do |locale|
      Ecm::Cms::Navigation.where(:locale => locale).all.each do |navigation|
        f.inputs do
          f.input :ecm_cms_navigation_items, 
                  :as => :check_boxes, 
                  :collection => navigation.ecm_cms_navigation_items.joins(:ecm_cms_navigation).where(:ecm_cms_navigations => { :locale => locale }), 
                  :label_method => :key # .all.collect { |i| "#{'--' * i.depth} #{i.name}" }
        end
      end
    end

#    I18n.available_locales.each do |locale|
#      Ecm::Cms::Navigation.where(:locale => locale).all.each do |navigation|
#        f.inputs :name => navigation do
#          f.input :ecm_cms_navigation_items, 
#                  :as => :check_boxes, 
#                  :collection => nested_set_options(
#                    navigation.ecm_cms_navigation_items.joins(:ecm_cms_navigation).where(:ecm_cms_navigations => { :locale => locale })
#                  ) { |i| "#{'--' * i.level} #{i.name}" },
#                  :selected => f.object.ecm_cms_navigation_items
#        end
#      end
#    end

    f.actions
  end

  index do
    selectable_column
    column :pathname
    column :filename
    column :title
    column :home_page?
    column :layout
    column :ecm_cms_navigation_items
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    panel Ecm::Cms::Page.human_attribute_name(:body) do
      pre { ecm_cms_page.body }
    end
  end

  sidebar Ecm::Cms::Page.human_attribute_name(:details), :only => :show do
    attributes_table_for ecm_cms_page do
      # row :ecm_cms_navigation_item
      # row :folder
      row :pathname
      row :filename
      row :home_page?
      row :layout
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

