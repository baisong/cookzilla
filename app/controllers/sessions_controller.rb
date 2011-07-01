class SessionsController < ApplicationController
def create
  auth = request.env["omniauth.auth"]
  user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  session[:user_id] = user.id
  redirect_to root_url, :notice => "Signed in as "+user.name+"!"
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Signed out!"
end

def user_index
	if signed_in?
		
			redirect_to :controller => :users, :action=> :show, :id =>session[:user_id]
		
		
	else
		redirect_to  :controller => :recipes, :action => :index
  end
  end
def index
	redirect_to  :controller => :recipes, :action => :index
end
end
