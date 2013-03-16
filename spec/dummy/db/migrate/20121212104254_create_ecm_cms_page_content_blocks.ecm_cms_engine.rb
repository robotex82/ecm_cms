# This migration comes from ecm_cms_engine (originally 8)
class CreateEcmCmsPageContentBlocks < ActiveRecord::Migration
  def change
    create_table :ecm_cms_page_content_blocks do |t|
      t.text :body

      # associations
      t.references :ecm_cms_page
      t.references :ecm_cms_content_box

      t.timestamps
    end
    add_index :ecm_cms_page_content_blocks, :ecm_cms_page_id
    add_index :ecm_cms_page_content_blocks, :ecm_cms_content_box_id
  end
end
