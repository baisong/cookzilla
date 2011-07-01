class Category < ActiveRecord::Base
def self.populate
	names = ["Vegetarian", "Vegan", "Gluten Free", "Appetizer", "Main Course", "Dessert", "Beverage", "MEAT!!!", "High Protein", "High Carbohydrate", "High Fat", "Requires No Cooking Experience", "Requires No Stove", "Cheap", "Only Uses Staples", "Matt Ritter"]
	names.each do |c|
			category = Category.new :name => c
			category.save!
			end
		end
after_save :set_recipe_delta_flag
private
def set_recipe_delta_flag
	recipe.delta = true
	recipe.save!
end
end
