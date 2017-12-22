# frozen_string_literal: true

class PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]
  before_action :set_policy

  def index
    @policy.authorize! :index?
    @publishers = Publisher.all
  end

  def show
    @policy.authorize! :show?
  end

  def new
    @policy.authorize! :new?
    @publisher = Publisher.new
  end

  def edit
    @policy.authorize! :edit?
  end

  def create
    @policy.authorize! :create?
    @publisher = Publisher.new(publisher_params)
    respond_to do |format|
      if @publisher.save
        format.html { redirect_to @publisher, notice: 'Publisher was successfully created.' }
        format.json { render :show, status: :created, location: @publisher }
      else
        format.html { render :new }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { redirect_to @publisher, notice: 'Publisher was successfully updated.' }
        format.json { render :show, status: :ok, location: @publisher }
      else
        format.html { render :edit }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @policy.authorize! :destroy?
    @publisher.destroy
    respond_to do |format|
      format.html { redirect_to publishers_url, notice: 'Publisher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Authorization Policy
    def set_policy
      @policy = PublishersPolicy.new(SubjectPolicyAgent.new(:User, current_user), ObjectPolicyAgent.new(:Publisher, @publisher))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:name, :display_name, :domain_id)
    end
end
