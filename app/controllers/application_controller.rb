require 'policy_errors'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from NotAuthorizedError, with: :render_unauthorized

  def current_user
    @user ||= User.nobody
  end

  protected

    def render_unauthorized(_exception = nil)
      respond_to do |format|
        # format.html { render 'unauthorized', status: :unauthorized }
        format.any { head :unauthorized, content_type: 'text/plain' }
      end
    end
end
