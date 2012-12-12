ActiveAdmin.register Ecm::Cms::ContentBox do
  # Menu
  menu :parent => Proc.new { I18n.t('ecm.cms.active_admin.menu') }.call

  index do
    selectable_column
    column :name
    column :created_at
    column :updated_at    
    default_actions
  end

  show do
    panel Ecm::Cms::ContentBox.human_attribute_name(:ecm_cms_page_content_blocks) do
      table_for ecm_cms_content_box.ecm_cms_page_content_blocks, :i18n => Ecm::Cms::Page::ContentBlock do |content_block|
        column :ecm_cms_page
        column :body
        column :created_at
        column :updated_at
      end
    end
  end

  sidebar Ecm::Cms::ContentBox.human_attribute_name(:details), :only => :show do
    attributes_table_for ecm_cms_content_box do
      row :name
      row :created_at
      row :updated_at
      row :ecm_cms_page_content_blocks_count
    end
  end # sidebar
end
