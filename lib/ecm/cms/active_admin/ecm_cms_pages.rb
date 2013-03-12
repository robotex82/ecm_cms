ActiveAdmin.register Ecm::Cms::Page do
  # Menu
  menu :parent => Proc.new { I18n.t('ecm.cms.active_admin.menu') }.call

  form do |f|
    f.translate_inputs do |ti|
      f.inputs do
        ti.input :title
        ti.input :meta_description
        ti.input :body
        ti.input :pathname
        ti.input :basename
      end
    end

    f.inputs do
      f.has_many :ecm_cms_page_content_blocks do |cb|
        if cb.object.persisted?
          cb.input :_destroy, :as => :boolean, :label => I18n.t('active_admin.delete')
        end

        cb.input :ecm_cms_content_box
        cb.input :body
      end
    end if Ecm::Cms::ContentBox.count > 0

    f.inputs do
      f.input :format, :as => :select, :collection => Mime::SET.symbols.map(&:to_s)
      f.input :handler, :as => :select, :collection => ActionView::Template::Handlers.extensions.map(&:to_s)
    end

    f.inputs do
      f.input :layout
    end

    f.actions
  end

  index do
    selectable_column
    column :pathname
    column :filename
    column :title
    column :home_page?
    column :layout
    column :created_at
    column :updated_at
    default_actions
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
      row :pathname
      row :filename
      row :home_page?
      row :layout
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

