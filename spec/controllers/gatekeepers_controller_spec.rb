# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GatekeepersController, type: :controller do
  context 'policy' do
    context 'unauthorized' do
      describe '#create' do
        it_should_behave_like 'unauthorized#create', :gatekeeper, :Gatekeeper
      end

      describe '#destory' do
        it_should_behave_like 'unauthorized#destroy', :gatekeeper, :Gatekeeper
      end

      describe '#edit' do
        it_should_behave_like 'unauthorized#edit', :gatekeeper, :Gatekeeper
      end

      describe '#index' do
        it_should_behave_like 'unauthorized#index', :gatekeeper
      end

      describe '#new' do
        it_should_behave_like 'unauthorized#new', :gatekeeper
      end

      describe '#show' do
        it_should_behave_like 'unauthorized#show', :gatekeeper, :Gatekeeper
      end

      describe '#update' do
        it_should_behave_like 'unauthorized#update', :gatekeeper, :Gatekeeper
      end
    end

    context 'authorized' do
      describe '#create success' do
        it_should_behave_like 'authorized#create', :gatekeeper, :Gatekeeper, true
      end

      describe '#create fail' do
        it_should_behave_like 'authorized#create', :gatekeeper, :Gatekeeper, false
      end

      describe '#destory' do
        it_should_behave_like 'authorized#destroy', :gatekeeper, :Gatekeeper
      end

      describe '#edit' do
        it_should_behave_like 'authorized#edit', :gatekeeper, :Gatekeeper
      end

      describe '#index' do
        it_should_behave_like 'authorized#index', :gatekeeper
      end

      describe '#new' do
        it_should_behave_like 'authorized#new', :gatekeeper
      end

      describe '#show' do
        it_should_behave_like 'authorized#show', :gatekeeper, :Gatekeeper
      end

      describe '#update success' do
        it_should_behave_like 'authorized#update', :gatekeeper, :Gatekeeper, true
      end

      describe '#update fail' do
        it_should_behave_like 'authorized#update', :gatekeeper, :Gatekeeper, false
      end
    end
  end
end
