class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  private
  def login_required
    redirect_to new_session_path unless current_user
  end
  def logined_not_user_new
    redirect_to tasks_path, notice:"ユーザー新規作成の場合はログアウトしてください" if logged_in?
  end
end
