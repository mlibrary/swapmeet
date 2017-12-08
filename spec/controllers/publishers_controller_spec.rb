# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublishersController, type: :controller do
  let(:user) { build(:user, id: 1) }
  let(:target) { build(:publisher, id: 1) }

  before do
    allow(controller).to receive(:current_user).and_return(current_user)
    allow(user).to receive(:persisted?).and_return(true)
    allow(Publisher).to receive(:find).with('1').and_return(target)
  end

  context 'unauthorized' do
    describe '#index' do
      it_should_behave_like 'unauthorized#index', :publisher do
        let(:response_check) do
          expect(response).to be_unauthorized
        end
      end
    end
  end

  context 'authorized' do
    describe '#index' do
      it_should_behave_like 'authorized#index', :publisher do
        let(:response_check) do
          expect(response).to be_success
        end
      end
    end
  end

  context 'anonymous user' do
    let(:current_user) { User.guest }

    describe '#create' do
      subject { post :create, params: { publisher: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#destory' do
      subject { delete :destroy, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#edit' do
      subject { get :edit, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#index' do
      subject { get :index }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#new' do
      subject { get :new }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#show' do
      subject { get :show, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#update' do
      subject { post :update, params: { id: target.id, publisher: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end
  end

  context 'authenticated user' do
    let(:current_user) { user }

    describe '#create' do
      subject { post :create, params: { publisher: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#destory' do
      subject { delete :destroy, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#edit' do
      subject { get :edit, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#index' do
      subject { get :index }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#new' do
      subject { get :new }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#show' do
      subject { get :show, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end

    describe '#update' do
      subject { post :update, params: { id: target.id, publisher: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end
  end
end
