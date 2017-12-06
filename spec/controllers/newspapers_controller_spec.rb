# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewspapersController, type: :controller do
  let(:publisher) { create(:publisher) }
  let(:target) { create(:newspaper, publisher: publisher) }

  context 'anonymous user' do
    describe '#create' do
      subject { post :create, params: { newspaper: { name: 'Name', display_name: 'Display Name' } } }
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
      subject { post :update, params: { id: target.id, newspaper: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end
  end

  context 'authenticated user' do
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe '#create' do
      subject { post :create, params: { newspaper: { name: 'Name', display_name: 'Display Name' } } }
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
      subject { post :update, params: { id: target.id, newspaper: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end
  end
end
