class TweetController < ApplicationController
  def view_tweets
    if logged_in
      @user = User.find(session[:user_id])
      if params[:per_page] && is_integer?(params[:per_page]) && params[:per_page].to_i>15
        per_page = params[:per_page]
      else
        per_page = 5
      end
      if params[:page] && is_integer?(params[:page]) && params[:page].to_i>0
        page = params[:page]
      else
        page = 1;
      end
      @tweets = Tweet.where(user_id: @user.followee_ids << @user.id).paginate(per_page: per_page, page: page, order: 'created_at DESC')
    else
      redirect_to controller: :user, action: :login and return
    end
  end
end
