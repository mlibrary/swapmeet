# frozen_string_literal: true

class NewspapersController < ApplicationController
  def index
    @policy.authorize! :index?
    @newspapers = Newspaper.all
  end

  def show
    @policy.authorize! :show?, @newspaper
  end

  def new
    if params[:publisher_id].present?
      @publisher = Publisher.find(params[:publisher_id])
      @policy.authorize! :new?, @publisher
      @newspaper = Newspaper.new
    else
      @policy.authorize! :new?
      @newspaper = Newspaper.new
    end
  end

  def edit
    @policy.authorize! :edit?, @newspaper
  end

  def create
    @publisher = Publisher.find(newspaper_params[:publisher_id]) if newspaper_params[:publisher_id].present?
    @policy.authorize! :create?, @publisher
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

  def update
    @policy.authorize! :update?, @newspaper
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

  def destroy
    @policy.authorize! :destroy?, @newspaper
    @newspaper.destroy
    respond_to do |format|
      format.html { redirect_to newspapers_url, notice: 'Newspaper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Authorization Policy
    def new_policy
      @newspaper = Newspaper.find(params[:id]) if params[:id].present?
      NewspapersPolicy.new(UserPolicyAgent.new(current_user), ObjectPolicyAgent.new(:Newspaper, @newspaper))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newspaper_params
      params.require(:newspaper).permit(:name, :display_name, :publisher_id)
    end
end
