# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GatekeepersController, type: :controller do
  let(:user) { build(:user, id: 1) }
  let(:target) { build(:gatekeeper, id: 1) }

  before do
    allow(controller).to receive(:current_user).and_return(current_user)
    allow(user).to receive(:persisted?).and_return(true)
    allow(Gatekeeper).to receive(:find).with('1').and_return(target)
  end

  context 'anonymous user' do
    let(:current_user) { User.guest }

    describe '#create' do
      subject { post :create, params: { gatekeeper: { name: 'Name', display_name: 'Display Name' } } }
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
      subject { post :update, params: { id: target.id, gatekeeper: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to be_unauthorized }
    end
  end

  context 'authenticated user' do
    let(:current_user) { user }

    describe '#create' do
      subject { post :create, params: { gatekeeper: { name: 'Name', display_name: 'Display Name' } } }
      before { subject }
      it { expect(response).to redirect_to gatekeeper_path(Gatekeeper.last) }
    end

    describe '#destory' do
      subject { delete :destroy, params: { id: target.id } }
      before { subject }
      it { expect(response).to redirect_to gatekeepers_path }
    end

    describe '#edit' do
      subject { get :edit, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_success }
    end

    describe '#index' do
      subject { get :index }
      before { subject }
      it { expect(response).to be_success }
    end

    describe '#new' do
      subject { get :new }
      before { subject }
      it { expect(response).to be_success }
    end

    describe '#show' do
      subject { get :show, params: { id: target.id } }
      before { subject }
      it { expect(response).to be_success }
    end

    describe '#update' do
      subject { post :update, params: { id: target.id, gatekeeper: { role: 'Role' } } }
      before { subject }
      it { expect(response).to redirect_to gatekeeper_path(target) }
    end
  end
end
