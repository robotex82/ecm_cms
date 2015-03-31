ActiveAdmin.register Ecm::Cms::Page do
  permit_params(:basename,
                :body,
                :ecm_cms_folder_id,
                :ecm_cms_navigation_item_ids,
                :ecm_cms_page_content_blocks_attributes,
                :format,
                :handler,
                :layout,
                :locale,
                :meta_description,
                :pathname,
                :title) if Rails.version >= '4.0.0'


  menu :parent => Proc.new { I18n.t('ecm.cms.active_admin.menu') }.call

  form do |f|
#    f.inputs do
#      f.object.errors.inspect
#    end

    f.inputs do
      f.input :title
      f.input :meta_description
      f.input :body
    end

    f.has_many :ecm_cms_page_content_blocks do |cb|
      # cb.inputs do
        if cb.object.persisted?
          cb.input :_destroy, :as => :boolean, :label => I18n.t('active_admin.delete')
        end

        cb.input :ecm_cms_content_box
        cb.input :body
      # end
    end if Ecm::Cms::ContentBox.count > 0

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
        f.inputs navigation.to_s do
          f.input :ecm_cms_navigation_items,
                  :as => :check_boxes,
                  :collection => navigation.ecm_cms_navigation_items.joins(:ecm_cms_navigation).where(:ecm_cms_navigations => { :locale => locale }),
                  :label_method => :key # .all.collect { |i| "#{'--' * i.depth} #{i.name}" }
        end
      end
    end

    f.actions
  end

  index do
    selectable_column
    column :pathname
    column :filename, :sortable => :basename
    column :title
    column :home_page?
    column :layout
    column(:ecm_cms_navigation_items) do |page|
      output = ""
      page.ecm_cms_navigation_items.each do |navigation_item|
        output << link_to(navigation_item, [:admin, navigation_item])
      end
      output.html_safe
    end
    column :created_at
    column :updated_at
    ActiveAdmin::VERSION[0] < '1' ? default_actions : actions
  end

  show do
    panel Ecm::Cms::Page.human_attribute_name(:body) do
      pre { ecm_cms_page.body }
    end

    ecm_cms_page.ecm_cms_page_content_blocks.each do |content_block|
      panel content_block.content_box_name do
        pre { content_block.body }
      end
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

