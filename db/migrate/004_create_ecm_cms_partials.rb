class CreateEcmCmsPartials < ActiveRecord::Migration
  def change
    create_table :ecm_cms_partials do |t|
      t.string :basename
      t.string :pathname
      t.text :body
      t.string :layout
      t.string :locale
      t.string :format
      t.string :handler

      # associations      
      t.references :ecm_cms_folder

      t.timestamps
    end
    add_index :ecm_cms_partials, :ecm_cms_folder_id
  end
end
