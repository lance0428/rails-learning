class AuthRequiredController < ApplicationController
  before_action :ensure_logged_in

  def ensure_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
