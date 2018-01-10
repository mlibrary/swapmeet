# frozen_string_literal: true

class PrivilegesController < ApplicationController
  before_action :set_privilege

  def index
  end

  def permit
    @policy.authorize! :permit?
    if params[:publisher_id].present?
      publisher = Publisher.find(params[:publisher_id])
      user = User.find(params[:user_id])
      policy_maker = PolicyMaker.new(RequestorPolicyAgent.new(:User, current_user))
      respond_to do |format|
        if policy_maker.permit!(
          SubjectPolicyAgent.new(:User, user),
          VerbPolicyAgent.new(:Role, :administrator),
          ObjectPolicyAgent.new(:Publisher, publisher)
        )
          format.html { redirect_to publisher_path(publisher), notice: 'Privilege was successfully permitted.' }
          format.json { head :no_content }
        else
          format.html { redirect_to publisher_path(publisher), notice: 'Privilege was NOT successfully permitted.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Privilege was NOT successfully permitted.' }
        format.json { head :no_content }
      end
    end
  end

  def revoke
    @policy.authorize! :revoke?
    if params[:publisher_id].present?
      publisher = Publisher.find(params[:publisher_id])
      user = User.find(params[:user_id])
      policy_maker = PolicyMaker.new(RequestorPolicyAgent.new(:User, current_user))
      respond_to do |format|
        if policy_maker.revoke!(
          SubjectPolicyAgent.new(:User, user),
          VerbPolicyAgent.new(:Role, :administrator),
          ObjectPolicyAgent.new(:Publisher, publisher)
        )
          format.html { redirect_to publisher_path(publisher), notice: 'Privilege was successfully revoked.' }
          format.json { head :no_content }
        else
          format.html { redirect_to publisher_path(publisher), notice: 'Privilege was NOT successfully revoked.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Privilege was NOT successfully revoked.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Authorization Policy
    def new_policy
      PrivilegesPolicy.new(SubjectPolicyAgent.new(:User, current_user), ObjectPolicyAgent.new(:Privilege, @privilege))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_privilege
      @privilege = Privilege.new(id: params[:id], requestor: current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def privilege_params
      params.require(:privilege).permit(:subject_type, :subject_id, :verb_type, :verb_id, :object_type, :object_id)
    end
end
