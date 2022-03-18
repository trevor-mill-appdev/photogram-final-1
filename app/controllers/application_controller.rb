class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  # before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "users/index.html.erb" })
  end

  def show_user
    

    url_username = params.fetch("username")
    matching_usernames = User.where({ :username => url_username })

    @the_user = matching_usernames.first
    if @current_user != nil
      render({ :template => "users/show.html.erb" })
    else
      redirect_to("/user_sign_in", { :alert => "You have to sign in first." })
    end
  end

  def test

    render({ :template => "/test.html.erb"})
  end

end
