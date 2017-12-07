# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_policy

  def create
    @policy.authorize! :create?
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @policy.authorize! :destroy?
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
    @policy.authorize! :edit?
  end

  def index
    @policy.authorize! :index?
    @groups = Group.all
  end

  def new
    @policy.authorize! :new?
    @group = Group.new
  end

  def show
    @policy.authorize! :show?
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Authorization Policy
    def set_policy
      @policy = GroupsPolicy.new(SubjectAgent.new(current_user), ObjectAgent.new(@group))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :display_name)
    end
end
