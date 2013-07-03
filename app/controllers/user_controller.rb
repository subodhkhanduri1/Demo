class UserController < ApplicationController
=begin
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save
  end
=end
  def check_login
    if session[:user_id]
      redirect_to action: :home and return
    end
  end

  def logged_in
    if session[:user_id]
      return true
    end
  end

  def login
=begin
    if session[:user_id]
      redirect_to action: :home and return
    end
=end
    @a=1
    self.check_login()

    if params[:submit]
      @user = User.find_last_by_username(params[:username])

      if @user
        puts @user.username
        puts @user.password
        if @user.username.to_s==params[:username].to_s && @user.password.to_s==params[:password].to_s
          session[:user_id]=@user.id
          puts session[:user_id]
          redirect_to action: :home and return
        end
      end
      @error=true;
    elsif params[:back]
      redirect_to '/'
      #redirect_to action: :login and return
    end
  end

  def sign_up
    if params[:back]
      redirect_to  action: :login and return
    end
    if params[:commit]
      if params[:password].to_s==params[:re_password]
        @user=User.new(:name => params[:name], :username => params[:username], :password => params[:password])
        @user.save
        if @user.errors
          @messages = @user.errors.full_messages
        else
          @message = "User '#{@user.username}' successfully created"
        end
      else
        @message = 'New Passwords dont match'
      end
    end

  end

  def home
    if logged_in
      @user = User.find(session[:user_id])
      @tweets = Tweet.where(user_id: @user.followee_ids << @user.id).order("created_at DESC").limit(10)
      @no_of_tweets = Tweet.where(user_id: @user.followee_ids << @user.id).size
      @followers = @user.followers.order("created_at ASC").limit(5)
      @no_of_followers = @user.followers.size
      @followees = @user.followees.order("created_at DESC").limit(5)
      @no_of_followees = @user.followees.size
    else
      redirect_to action: :login and return
    end
  end

  def profile
    if logged_in
      if params[:user] && is_integer?(params[:user]) && User.exists?(id: params[:user])
        @userpro = User.find(params[:user])
        @user = User.find(session[:user_id])
        if params[:per_page] && is_integer?(params[:per_page]) && params[:per_page].to_i>15
          per_page = params[:per_page]
        else
          per_page = 15
        end
        if params[:page] && is_integer?(params[:page]) && params[:page].to_i>0
          page = params[:page]
        else
          page = 1
        end
        @tweets = Tweet.where(user_id: @userpro.id).paginate(per_page: per_page, page: page, order: 'created_at DESC')
        @followers = @userpro.followers.order("created_at ASC").limit(5)
        @no_of_followers = @userpro.followers.size
        @followees = @userpro.followees.order("created_at DESC").limit(5)
        @no_of_followees = @userpro.followees.size
      else
        redirect_to action: :home and return
      end
    else
      redirect_to action:login and return
    end
  end

  def logout
    if session[:user_id]
      session.delete(:user_id)
    else
      redirect_to action: :login and return
    end
  end

  def edit_profile
    if session[:user_id]
      @user = User.find_last_by_id(session[:user_id])
    else
      redirect_to action: :login and return
    end
  end

  def change_password
    if session[:user_id]
      if params[:back]
        redirect_to action: :edit_profile and return
      end
      @user = User.find(session[:user_id])
      if params[:commit]
        if(params[:new_password].to_s==params[:re_password].to_s)
          if params[:old_password].to_s==@user.password.to_s
            @user.password = params[:new_password]
            @user.save
            if @user.errors.full_messages.size>0
              session[:messages] = @user.errors.full_messages
            else
              @message='Password successfully changed'
            end
          else
            @message='Invalid Password'
          end
        else
          @message='New Passwords dont match'
        end
      end
    else
      redirect_to action: :login and return
    end
  end

  def change_name
    if logged_in
      if params[:back]
        redirect_to action: :edit_profile and return
      end
      @user = User.find(session[:user_id])
      if params[:commit]
          if params[:name]
            @user.name = params[:name]
            @user.save
            if @user.errors.full_messages.size>0
              session[:messages] = @user.errors.full_messages
            end
            @message='Name successfully changed'
          end
      end
    else
      redirect_to action: :login and return
    end
  end

  def post_tweet
    if logged_in
      if params[:commit]
        #if(params[:tweet_message].to_s.length>200)
         # session[:message] = 'Tweet must not exceed 200 characters!'
        #else
          @tweet = Tweet.new(:user_id => session[:user_id],:message => params[:tweet_message])
          @tweet.save
          session[:messages] = @tweet.errors.full_messages
        #end
        redirect_to action: :home and return
      end
    else
      redirect_to action: :login and return
    end
  end

  def view_followers
    if logged_in
      @user = User.find(session[:user_id])
      if params[:per_page] && is_integer?(params[:per_page]) && params[:per_page].to_i>15
        per_page = params[:per_page]
      else
        per_page = 15
      end
      if params[:page] && is_integer?(params[:page]) && params[:page].to_i>0
        page = params[:page]
      else
        page = 1
      end
      @followers = User.find(session[:user_id]).followers.paginate(per_page: per_page, page: page, order: 'created_at DESC')
    else
      redirect_to action: :login and return
    end
  end

  def view_followees
    if logged_in
      @user = User.find(session[:user_id])
      if params[:per_page] && is_integer?(params[:per_page]) && params[:per_page].to_i>15
        per_page = params[:per_page]
      else
        per_page = 15
      end
      if params[:page] && is_integer?(params[:page]) && params[:page].to_i>0
        page = params[:page]
      else
        page = 1
      end
      @followees = User.find(session[:user_id]).followees.paginate(per_page: per_page, page: page, order: 'created_at DESC')
    else
    redirect_to action: :login and return
    end
  end
=begin
  def all_users
    if logged_in
      @user = User.find(session[:user_id])
      if params[:page_id] && is_integer?(params[:page_id])
        @users = User.where(User.arel_table[:id].not_eq(session[:user_id])).order("name ASC").limit(20).offset((params[:page_id].to_i-1)*20)
      elsif params[:page_id] && !is_integer?(params[:page_id])
        redirect_to action: :all_users and return
      else
        @users = User.where(User.arel_table[:id].not_eq(session[:user_id])).order("name ASC").limit(20)
      end
    else
      redirect_to action: :login and return
    end
  end
=end

  def self.search(per_page, page)
    paginate :per_page => per_page, :page => page,
             :order => 'name'
  end

  def all_users
    if logged_in
      @user = User.find(session[:user_id])
      if params[:per_page] && is_integer?(params[:per_page]) && params[:per_page].to_i>15
        per_page = params[:per_page]
      else
        per_page = 3
      end
      if params[:page] && is_integer?(params[:page]) && params[:page].to_i>0
        page = params[:page]
      else
        page = 1
      end
      @users = User.where(User.arel_table[:id].not_eq(session[:user_id])).paginate(per_page: per_page, page: page, order: 'name')
    else
      redirect_to action: :login and return
    end
  end



  def index
  end

end
