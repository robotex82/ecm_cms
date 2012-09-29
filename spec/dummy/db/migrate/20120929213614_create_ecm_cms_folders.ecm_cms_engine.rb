# This migration comes from ecm_cms_engine (originally 1)
class CreateEcmCmsFolders < ActiveRecord::Migration
  def change
    create_table :ecm_cms_folders do |t|
      t.string :basename
      t.string :pathname

      # associations
      t.integer :children_count, :default => 0, :null => false
      t.integer :ecm_cms_templates_count, :default => 0, :null => false

      # awesome nested set
      t.references :parent
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
    add_index :ecm_cms_folders, :parent_id
  end
end
