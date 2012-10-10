# This migration comes from ecm_cms_engine (originally 5)
class CreateEcmCmsNavigations < ActiveRecord::Migration
  def change
    create_table :ecm_cms_navigations do |t|
      t.string :locale
      t.string :name

      # friendly id
      t.string :slug

      t.timestamps
    end
  end
end
