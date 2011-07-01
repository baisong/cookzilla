class AddDeltaToRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :recipes, :delta
  end
end
