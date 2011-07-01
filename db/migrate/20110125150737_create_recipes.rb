class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :name
      t.integer :username
      t.integer :serving
      t.float :price
      t.text :ingredient
      t.text :procedure

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
