# frozen_string_literal: true

require 'policy_errors'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?

  before_action :set_policies

  rescue_from NotAuthorizedError, with: :render_unauthorized

  def indexes
  end

  protected

    def auto_login(user)
      session[:user_id] = user.id
    end

    def logout!
      session[:user_id] = nil
    end

    def current_user
      unless defined?(@current_user)
        @current_user = user_from_session || User.guest
      end
      @current_user
    end

    def logged_in?
      current_user.known?
    end

    def user_from_session
      User.find_by_id(session.fetch(:user_id, nil))
    end

    def render_unauthorized(_exception = nil)
      respond_to do |format|
        format.html { render 'unauthorized', status: :unauthorized }
        format.json { head :unauthorized }
      end
    end

  private

    def set_policies
      @categories_policy = CategoriesPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Category, nil))
      @domains_policy = DomainsPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Domain, nil))
      @gatekeepers_policy = GatekeepersPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Gatekeeper, nil))
      @groups_policy = GroupsPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Group, nil))
      @listings_policy = ListingPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Listing, nil))
      @newspapers_policy = NewspapersPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Newspaper, nil))
      @publishers_policy = PublishersPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Publisher, nil))
      @users_policy = UsersPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:User, nil))
    end
end
