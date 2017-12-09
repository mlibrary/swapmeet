# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainsController, type: :controller do
  context 'policy' do
    context 'unauthorized' do
      describe '#create' do
        it_should_behave_like 'unauthorized#create', :domain, :Domain
      end

      describe '#destory' do
        it_should_behave_like 'unauthorized#destroy', :domain, :Domain
      end

      describe '#edit' do
        it_should_behave_like 'unauthorized#edit', :domain, :Domain
      end

      describe '#index' do
        it_should_behave_like 'unauthorized#index', :domain
      end

      describe '#new' do
        it_should_behave_like 'unauthorized#new', :domain
      end

      describe '#show' do
        it_should_behave_like 'unauthorized#show', :domain, :Domain
      end

      describe '#update' do
        it_should_behave_like 'unauthorized#update', :domain, :Domain
      end
    end

    context 'authorized' do
      describe '#create' do
        it_should_behave_like 'authorized#create', :domain, :Domain
      end

      describe '#destory' do
        it_should_behave_like 'authorized#destroy', :domain, :Domain
      end

      describe '#edit' do
        it_should_behave_like 'authorized#edit', :domain, :Domain
      end

      describe '#index' do
        it_should_behave_like 'authorized#index', :domain
      end

      describe '#new' do
        it_should_behave_like 'authorized#new', :domain
      end

      describe '#show' do
        it_should_behave_like 'authorized#show', :domain, :Domain
      end

      describe '#update' do
        it_should_behave_like 'authorized#update', :domain, :Domain
      end
    end
  end
end
