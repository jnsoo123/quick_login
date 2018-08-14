class QuickLogin::QuickLoginController < ApplicationController
  include Rails.application.routes.url_helpers

  skip_before_action :authenticate_user!

  before_action :set_user

  def login
    if Rails.env.development?
      sign_in model_sym, @user
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  private

  def set_user
    @user = model.find_by_id(params[:id])
  end

  def model
    class_eval(params[:model])
  end

  def model_sym
    model.to_s.underscore.to_sym
  end
end
