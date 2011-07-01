class Recipe < ActiveRecord::Base
	validates :name,  :presence => true
	validates :serving,  :presence => true
	validates :price,  :presence => true
	validates_numericality_of :serving, :greater_than => 0
	validates_numericality_of :price, :greater_than => 0

cattr_reader :per_page
  @@per_page = 20
  
define_index  do
	indexes name, :sortable => true
	indexes price, :sortable => true
	indexes username, :sortable => true
	indexes categories.name, :as => :categories
	indexes ingredient
	indexes procedure
	set_property :delta => true
end

has_many :recipe_categories, :dependent => :destroy
has_many :categories, :through => :recipe_categories  
belongs_to :user
has_many :ratings, :dependent => :destroy
has_many :raters, :through => :ratings, :source => :users

def self.get_categories(id)
	f1 = RecipeCategory.find_by_sql("SELECT `category_id` FROM `recipe_categories` WHERE `recipe_id` = "+id.to_s())
	f2 = f1.map {|c|
		Category.find_by_sql("SELECT `name` FROM `categories` WHERE `id` = "+c.category_id.to_s())}
	f2.uniq
end

def self.get_user(id)
	f1 = User.find_by_sql("SELECT `name` FROM `users` WHERE `id` = "+ id.to_s())
end

def self.get_date(id)
	f1 = Recipe.find_by_sql("SELECT `updated_at` FROM `recipes` WHERE `id` = "+id.to_s()).first.updated_at
end

def average_rating
    @value = 0
    self.ratings.each do |rating|
        @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f
end

end
