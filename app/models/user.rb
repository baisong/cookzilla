class User < ActiveRecord::Base
cattr_reader :per_page
  @@per_page = 20
  
define_index  do
	indexes name, :sortable => true
	indexes email
	set_property :delta => true
end

def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["user_info"]["name"]
	
end
end

has_many :recipes, :dependent => :destroy
has_many :ratings,  :dependent => :destroy
has_many :rated_recipes, :through => :ratings, :source => :recipes

def self.get_recipes(id)
	f1 = Recipe.find_by_sql("SELECT `id` FROM `recipes` WHERE `username` = "+id.to_s())
	f1.uniq
end

validates_presence_of :name

end
