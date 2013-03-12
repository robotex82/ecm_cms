# This migration comes from ecm_cms_engine (originally 2)
class CreateEcmCmsPages < ActiveRecord::Migration
  def change
    create_table :ecm_cms_pages do |t|
      t.translate_columns do |tc|
        tc.string :basename
        tc.string :pathname
        tc.string :title
        tc.text :meta_description
        tc.text :body
      end
      t.string :layout
      t.string :format
      t.string :handler
      t.references :ecm_cms_folder

      t.timestamps
    end
    add_index :ecm_cms_pages, :ecm_cms_folder_id
  end
end
