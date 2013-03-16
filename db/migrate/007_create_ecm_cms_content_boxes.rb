class CreateEcmCmsContentBoxes < ActiveRecord::Migration
  def change
    create_table :ecm_cms_content_boxes do |t|
      t.string :name

      t.timestamps
    end
  end
end
