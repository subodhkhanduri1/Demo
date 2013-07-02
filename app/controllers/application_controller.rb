class ApplicationController < ActionController::Base
  def logged_in
    if session[:user_id]
      return true
    end
  end

  def is_integer?(s)
    s.to_i.to_s==s
  end
end
