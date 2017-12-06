# frozen_string_literal: true

class NewspapersController < ApplicationController
  before_action :set_newspaper, only: [:show, :edit, :update, :destroy]
  before_action :set_policy

  def create
    @policy.authorize! :create?
    @newspaper = Newspaper.new(newspaper_params)

    respond_to do |format|
      if @newspaper.save
        format.html { redirect_to @newspaper, notice: 'Newspaper was successfully created.' }
        format.json { render :show, status: :created, location: @newspaper }
      else
        format.html { render :new }
        format.json { render json: @newspaper.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @policy.authorize! :destroy?
    @newspaper.destroy
    respond_to do |format|
      format.html { redirect_to newspapers_url, notice: 'Newspaper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
    @policy.authorize! :edit?
  end

  def index
    @policy.authorize! :index?
    @newspapers = Newspaper.all
  end

  def new
    @policy.authorize! :new?
    @newspaper = Newspaper.new
  end

  def show
    @policy.authorize! :show?
  end

  def update
    @policy.authorize! :update?
    respond_to do |format|
      if @newspaper.update(newspaper_params)
        format.html { redirect_to @newspaper, notice: 'Newspaper was successfully updated.' }
        format.json { render :show, status: :ok, location: @newspaper }
      else
        format.html { render :edit }
        format.json { render json: @newspaper.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Authorization Policy
    def set_policy
      @policy = NewspapersPolicy.new(SubjectAgent.new(current_user), ObjectAgent.new(@newspaper))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_newspaper
      @newspaper = Newspaper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newspaper_params
      params.require(:newspaper).permit(:name, :display_name, :publisher_id)
    end
end
