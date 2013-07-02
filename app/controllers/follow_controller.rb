class FollowController < ApplicationController

  def create
    if logged_in
      if params[:commit]
      User.find(session[:user_id].to_i).followees << User.find(params[:following_id])
      end
      redirect_to controller: :user, action: :all_users and return
    else
      redirect_to controller: :user, action: :login and return
    end
  end

  def delete
    if logged_in
      if params[:commit]
        User.find(session[:user_id]).followees.destroy(User.find(params[:following_id]))
      end
      redirect_to controller: :user, action: :all_users and return
    else
      redirect_to controller: :user, action: :login and return
    end
  end
end
