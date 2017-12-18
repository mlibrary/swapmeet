# frozen_string_literal: true

class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]
  before_action :set_policy

  def index
    @policy.authorize! :index?
    @domains = Domain.all
  end

  def show
    @policy.authorize! :show?
  end

  def new
    @policy.authorize! :new?
    @domain = Domain.new
  end

  def edit
    @policy.authorize! :edit?
  end

  def create
    @policy.authorize! :create?
    @domain = Domain.new(domain_params)
    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render :show, status: :created, location: @domain }
      else
        format.html { render :new }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @policy.authorize! :destroy?
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Authorization Policy
    def set_policy
      @policy = DomainsPolicy.new(PolicyAgent.new(:User, current_user), PolicyAgent.new(:Doamin, @domain))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name, :display_name, :parent_id)
    end
end
