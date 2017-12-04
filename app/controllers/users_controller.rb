# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :set_policy

  def create
    return render_unauthorized unless @policy.authorize! :create?
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    return render_unauthorized unless @policy.authorize! :destroy?
    redirect_to users_path
  end

  def edit
    return render_unauthorized unless @policy.authorize! :edit?
  end

  def index
    return render_unauthorized unless @policy.authorize! :index?
    @users = User.all
  end

  def login
    return render_unauthorized unless @policy.authorize! :login?
    session[:current_user] = User.find(params[:id])
    redirect_to root_path
  end

  def logout
    return render_unauthorized unless @policy.authorize! :logout?
    session[:current_user] = User.nobody
    redirect_to root_path
  end

  def new
    return render_unauthorized unless @policy.authorize! :new?
    @user = User.new
  end

  def show
    return render_unauthorized unless @policy.authorize! :show?
  end

  def update
    return render_unauthorized unless @policy.authorize! :update?
    redirect_to users_path
  end

  private

    def set_user
      @user ||= params[:id].present? ? User.find(params[:id]) : User.nobody
    end

    def set_policy
      @policy ||= UsersPolicy.new(Agent.new(current_user), @user)
    end

    def user_params
      params.require(:user).permit(:display_name, :email)
    end
end
