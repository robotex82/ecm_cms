# This migration comes from ecm_cms_engine (originally 6)
class CreateEcmCmsNavigationItems < ActiveRecord::Migration
  def change
    create_table :ecm_cms_navigation_items do |t|
      t.string :name
      t.string :url
      t.string :key
      t.string :options

      # associations
      t.references :ecm_cms_navigation
      t.references :ecm_cms_page

      # awesome nested set
      t.references :parent
      t.integer :children_count, :default => 0, :null => false
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      # friendly id
      t.string :slug

      t.timestamps
    end
    add_index :ecm_cms_navigation_items, :ecm_cms_navigation_id
    add_index :ecm_cms_navigation_items, :parent_id
  end
end
