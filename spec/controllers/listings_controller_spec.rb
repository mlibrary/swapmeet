# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingsController do
  let(:user) { build(:user, id: 1) }
  let(:owner) { build(:user, id: 2) }
  let(:target) { build(:listing, id: 1, owner: owner) }

  before do
    allow(controller).to receive(:current_user).and_return(current_user)
    allow(user).to receive(:persisted?).and_return(true)
    allow(owner).to receive(:persisted?).and_return(true)
    allow(Listing).to receive(:find).with('1').and_return(target)
  end

  context 'anonymous user' do
    let(:current_user) { User.guest }

    describe '#create' do
      subject { post :create, params: { listing: { title: 'title', body: 'body' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#destroy' do
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

    describe '#new' do
      subject { get :new }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
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
      subject { put :update, params: { id: target.id, listing: { title: 'title', body: 'body' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end
  end

  context 'owner user' do
    let(:current_user) { owner }

    describe '#create' do
      subject { post :create, params: { listing: { title: 'title', body: 'body' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listings_path
      end
    end

    describe '#destroy' do
      subject { delete :destroy, params: { id: target.id } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listings_path
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
      subject { put :update, params: { id: target.id, listing: { title: 'title', body: 'body' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listing_path
      end
    end
  end

  context 'non-owner user' do
    let(:current_user) { user }

    describe '#create' do
      subject { post :create, params: { listing: { title: 'title', body: 'body' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listings_path
      end
    end

    describe '#destroy' do
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
      subject { put :update, params: { id: target.id, listing: { title: 'title', body: 'body' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end
  end
end
