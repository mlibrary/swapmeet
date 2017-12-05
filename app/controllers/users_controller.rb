# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :destroy, :login]
  before_action :set_policy

  def create
    @policy.authorize! :create?
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    @policy.authorize! :destroy?
    redirect_to users_path
  end

  def edit
    @policy.authorize! :edit?
  end

  def index
    @policy.authorize! :index?
    @users = User.all
  end

  def login
    @policy.authorize! :login?
    auto_login(@user)
    redirect_to root_path
  end

  def logout
    logout!
    redirect_to root_path
  end

  def new
    @policy.authorize! :new?
    @user = User.new
  end

  def show
    @policy.authorize! :show?
  end

  def update
    @policy.authorize! :update?
    redirect_to users_path
  end

  private

    def set_user
      @user ||= User.find(params[:id])
    end

    def set_policy
      @policy ||= UsersPolicy.new(Agent.new(current_user), @user)
    end

    def user_params
      params.require(:user).permit(:display_name, :email)
    end
end
