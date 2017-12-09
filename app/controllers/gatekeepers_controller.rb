# frozen_string_literal: true

class GatekeepersController < ApplicationController
  before_action :set_gatekeeper, only: [:show, :edit, :update, :destroy]
  before_action :set_policy

  def create
    @policy.authorize! :create?
    @gatekeeper = Gatekeeper.new(gatekeeper_params)
    respond_to do |format|
      if @gatekeeper.save
        format.html { redirect_to @gatekeeper, notice: 'Gatekeeper was successfully created.' }
        format.json { render :show, status: :created, location: @gatekeeper }
      else
        format.html { render :new }
        format.json { render json: @gatekeeper.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @policy.authorize! :destroy?
    @gatekeeper.destroy
    respond_to do |format|
      format.html { redirect_to gatekeepers_url, notice: 'Gatekeeper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
    @policy.authorize! :edit?
  end

  def index
    @policy.authorize! :index?
    @gatekeepers = Gatekeeper.all
    @presenters = ObjectPresenter.for_objects(@gatekeepers)
  end


  def new
    @policy.authorize! :new?
    @gatekeeper = Gatekeeper.new
    @presenter = ObjectPresenter.for_object(@gatekeeper)
  end

  def show
    @policy.authorize! :show?
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if @gatekeeper.update(gatekeeper_params)
        format.html { redirect_to @gatekeeper, notice: 'Gatekeeper was successfully updated.' }
        format.json { render :show, status: :ok, location: @gatekeeper }
      else
        format.html { render :edit }
        format.json { render json: @gatekeeper.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Authorization Policy
    def set_policy
      @policy = GatekeepersPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Gatekeeper, @gatekeeper))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_gatekeeper
      @gatekeeper = Gatekeeper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gatekeeper_params
      params.require(:gatekeeper).permit(:role, :domain_id, :group_id, :listing_id, :newspaper_id, :publisher_id, :user_id)
    end
end
