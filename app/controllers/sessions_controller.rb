class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login]

  def login
    auth_hash = request.env['omniauth.auth']
    # ap @auth_hash
    if auth_hash['uid']
      user = User.find_by(provider: params[:provider], uid: auth_hash['uid'])
      if user.nil?
        user = User.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(user)
      else
        flash[:status] = :success
        flash[:mesage] = "Successfully logged in as returning user #{user.name}"
      end

      #will log the user in
      session[:user_id] = user.id

    else
      flash[:status] = :failure
      flash[:message] = "Could not create user from OAuth process"
    end

    redirect_to root_path
  end #create

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "You have been logged out"
    redirect_to root_path
  end #logout

end #class













  #
  #     if user.save
  #       user.from_auth_hash(provider, auth_hash)
  #       session[:user_id] = user.id
  #       flash[:success] = "Welcome to #{user.name}"
  #     else
  #       flash[:error] = "Could not log in"
  #     end
  #   end
  #   redirect_to root_path
  #
  # end


  # def login_form
  # end
  #
  # def login
  #   username = params[:username]
  #   if username and user = User.find_by(username: username)
  #     session[:user_id] = user.id
  #     flash[:status] = :success
  #     flash[:result_text] = "Successfully logged in as existing user #{user.username}"
  #   else
  #     user = User.new(username: username)
  #     if user.save
  #       session[:user_id] = user.id
  #       flash[:status] = :success
  #       flash[:result_text] = "Successfully created new user #{user.username} with ID #{user.id}"
  #     else
  #       flash.now[:status] = :failure
  #       flash.now[:result_text] = "Could not log in"
  #       flash.now[:messages] = user.errors.messages
  #       render "login_form", status: :bad_request
  #       return
  #     end
  #   end
  #   redirect_to root_path
  # end
  #
  # def logout
  #   session[:user_id] = nil
  #   flash[:status] = :success
  #   flash[:result_text] = "Successfully logged out"
  #   redirect_to root_path
  # end
