# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :add, :remove]

  def index
    if params[:publisher_id].present?
      @publisher = Publisher.find(params[:publisher_id])
      @groups = Group.all
      render "publishers/groups"
    else
      @policy.authorize! :index?
      @groups = Group.all
      render
    end
  end

  def show
    @policy.authorize! :show?
  end

  def new
    @policy.authorize! :new?
    @group = Group.new
  end

  def edit
    @policy.authorize! :edit?
  end

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

  def destroy
    @policy.authorize! :destroy?
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add
    if params[:publisher_id].present?
      publisher = Publisher.find(params[:publisher_id])
      publisher.groups << @group
      respond_to do |format|
        format.html { redirect_to publisher_groups_path(publisher), notice: 'Group was successfully added..' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to groups_path, notice: 'Group was not successfully added.' }
        format.json { head :no_content }
      end
    end
  end

  def remove
    if params[:publisher_id].present?
      publisher = Publisher.find(params[:publisher_id])
      publisher.groups.delete(@group)
      respond_to do |format|
        format.html { redirect_to publisher_groups_path(publisher), notice: 'Group was successfully removed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to groups_path, notice: 'Group was not successfully removed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Authorization Policy
    def new_policy
      GroupsPolicy.new(SubjectPolicyAgent.new(:User, current_user), ObjectPolicyAgent.new(:Group, @group))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :display_name, :parent_id)
    end
end
