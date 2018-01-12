# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it_should_behave_like 'policy enforcer', :user, :User

  context 'authenticate' do
    describe '#login' do
      subject { post :login, params: { id: user.id } }
      let(:user) { build(:user, id: 1) }
      before do
        allow(User).to receive(:find).with('1').and_return(user)
        subject
      end
      it 'signs in' do
        expect(session[:user_id]).to be user.id
        expect(response).to redirect_to root_path
      end
    end

    describe '#logout' do
      subject { post :logout }
      let(:user) { build(:user, id: 1) }
      before do
        allow(User).to receive(:find).with('1').and_return(user)
        post :login, params: { id: user.id }
        subject
      end
      it 'signs off' do
        expect(session[:user_id]).to be nil
        expect(response).to redirect_to root_path
      end
    end
  end

  context 'group policy enforcement' do
    context 'unauthorized' do
      describe '#join' do
        subject { patch :join, params: { group_id: group.id, id: user.id } }
        let(:group) { build(:group, id: 1) }
        let(:user) { build(:user, id: 2) }
        controller do
          def set_policy
            @policy = ControllersHelper::UnauthorizePolicy.new
          end
        end
        before do
          routes.draw { patch "/groups/:group_id/users/:id/join" => "users#join" }
          allow(Group).to receive(:find).with('1').and_return(group)
          allow(User).to receive(:find).with('2').and_return(user)
          subject
        end
        it "join group unautorized" do
          expect(response).to be_unauthorized
        end
      end

      describe '#leave' do
        subject { delete :leave, params: { group_id: group.id, id: user.id } }
        let(:group) { build(:group, id: 1) }
        let(:user) { build(:user, id: 2) }
        controller do
          def set_policy
            @policy = ControllersHelper::UnauthorizePolicy.new
          end
        end
        before do
          routes.draw { delete "/groups/:group_id/users/:id/leave" => "users#leave" }
          allow(Group).to receive(:find).with('1').and_return(group)
          allow(User).to receive(:find).with('2').and_return(user)
          subject
        end
        it "leave group unautorized" do
          expect(response).to be_unauthorized
        end
      end
    end

    context 'authorized' do
      describe '#join' do
        subject { patch :join, params: { group_id: group.id, id: user.id } }
        let(:group) { build(:group, id: 1) }
        let(:user) { build(:user, id: 2) }
        controller do
          def set_policy
            @policy = ControllersHelper::AuthorizePolicy.new
          end
        end
        before do
          controller.instance_variable_set("@user", user)
          routes.draw { patch "/groups/:group_id/users/:id/join" => "users#join" }
          allow(Group).to receive(:find).with('1').and_return(group)
          allow(User).to receive(:find).with('2').and_return(user)
          subject
        end
        it "join group autorized" do
          expect(response).to have_http_status(:found)
        end
      end

      describe '#leave' do
        subject { delete :leave, params: { group_id: group.id, id: user.id } }
        let(:group) { build(:group, id: 1) }
        let(:user) { build(:user, id: 2) }
        controller do
          def set_policy
            @policy = ControllersHelper::AuthorizePolicy.new
          end
        end
        before do
          controller.instance_variable_set("@user", user)
          routes.draw { delete "/groups/:group_id/users/:id/leave" => "users#leave" }
          allow(Group).to receive(:find).with('1').and_return(group)
          allow(User).to receive(:find).with('2').and_return(user)
          subject
        end
        it "leave group autorized" do
          expect(response).to have_http_status(:found)
        end
      end
    end
  end
end
