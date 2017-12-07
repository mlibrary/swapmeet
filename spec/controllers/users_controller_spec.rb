# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { build(:user, id: 1) }
  let(:target) { build(:user, id: 2) }

  before do
    allow(controller).to receive(:current_user).and_return(current_user)
    allow(user).to receive(:persisted?).and_return(true)
    allow(target).to receive(:persisted?).and_return(true)
    allow(User).to receive(:find).with('2').and_return(target)
  end

  context 'anonymous user' do
    let(:current_user) { User.guest }

    describe '#create' do
      subject { post :create, params: { user: { display_name: 'name', email: 'name@example.com' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to users_path
      end
    end

    describe '#destory' do
      subject { delete :destroy, params: { id: target.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#edit' do
      subject { get :edit, params: { id: target.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#index' do
      subject { get :index }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#login' do
      subject { post :login, params: { id: target.id } }
      it 'authorized' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    describe '#logout' do
      subject { post :logout }
      it 'authorized' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    describe '#new' do
      subject { get :new }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#show' do
      subject { get :show, params: { id: target.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#update' do
      subject { post :update, params: { id: target.id, user: { display_name: 'name', email: 'name@example.com' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end
  end

  context 'owner user' do
    let(:current_user) { target }

    describe '#create' do
      subject { post :create, params: { user: { display_name: 'name', email: 'name@example.com' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to users_path
      end
    end

    describe '#destory' do
      subject { delete :destroy, params: { id: target.id } }
      it 'authorized' do
        subject
        expect(response).to redirect_to users_path
      end
    end

    describe '#edit' do
      subject { get :edit, params: { id: target.id } }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#index' do
      subject { get :index }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#login' do
      subject { post :login, params: { id: target.id } }
      it 'authorized' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    describe '#logout' do
      subject { post :logout }
      it 'authorized' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    describe '#new' do
      subject { get :new }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#show' do
      subject { get :show, params: { id: target.id } }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#update' do
      subject { post :update, params: { id: target.id, user: { display_name: 'name', email: 'name@example.com' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to users_path
      end
    end
  end

  context 'non-owner user' do
    let(:current_user) { user }

    describe '#create' do
      subject { post :create, params: { user: { display_name: 'name', email: 'name@example.com' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to users_path
      end
    end

    describe '#destory' do
      subject { delete :destroy, params: { id: target.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#edit' do
      subject { get :edit, params: { id: target.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#index' do
      subject { get :index }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#login' do
      subject { post :login, params: { id: target.id } }
      it 'authorized' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    describe '#logout' do
      subject { post :logout }
      it 'authorized' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    describe '#new' do
      subject { get :new }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#show' do
      subject { get :show, params: { id: target.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#update' do
      subject { post :update, params: { id: target.id, user: { display_name: 'name', email: 'name@example.com' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end
  end
end
