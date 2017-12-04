# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingsController do
  context 'anonymous user' do
    let(:listing) { create(:listing) }

    describe '#create' do
      subject { post :create, params: { listing: { title: 'title', body: 'body' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#edit' do
      subject { get :edit, params: { id: listing.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#destroy' do
      subject { delete :destroy, params: { id: listing.id } }
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
      subject { get :show, params: { id: listing.id } }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#update' do
      subject { put :update, params: { id: listing.id, listing: { title: 'title', body: 'body' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end
  end

  context 'owner user' do
    let(:user) { create(:user) }
    let(:listing) { create(:listing, owner: user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe '#create' do
      subject { post :create, params: { listing: { title: 'title', body: 'body' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listings_path
      end
    end

    describe '#edit' do
      subject { get :edit, params: { id: listing.id } }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#destroy' do
      subject { delete :destroy, params: { id: listing.id } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listings_path
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
      subject { get :show, params: { id: listing.id } }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#update' do
      subject { put :update, params: { id: listing.id, listing: { title: 'title', body: 'body' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listing_path
      end
    end
  end

  context 'non-owner user' do
    let(:user) { create(:user) }
    let(:listing) { create(:listing, owner: user) }
    let(:current_user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(current_user)
    end

    describe '#create' do
      subject { post :create, params: { listing: { title: 'title', body: 'body' } } }
      it 'authorized' do
        subject
        expect(response).to redirect_to listings_path
      end
    end

    describe '#edit' do
      subject { get :edit, params: { id: listing.id } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end

    describe '#destroy' do
      subject { delete :destroy, params: { id: listing.id } }
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
      subject { get :show, params: { id: listing.id } }
      it 'authorized' do
        subject
        expect(response).to be_success
      end
    end

    describe '#update' do
      subject { put :update, params: { id: listing.id, listing: { title: 'title', body: 'body' } } }
      it 'unauthorized' do
        subject
        expect(response).to be_unauthorized
      end
    end
  end
end
