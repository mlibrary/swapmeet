# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublishersController, type: :controller do
  context 'policy' do
    context 'unauthorized' do
      describe '#create' do
        it_should_behave_like 'unauthorized#create', :publisher, :Publisher
      end

      describe '#destory' do
        it_should_behave_like 'unauthorized#destroy', :publisher, :Publisher
      end

      describe '#edit' do
        it_should_behave_like 'unauthorized#edit', :publisher, :Publisher
      end

      describe '#index' do
        it_should_behave_like 'unauthorized#index', :publisher
      end

      describe '#new' do
        it_should_behave_like 'unauthorized#new', :publisher
      end

      describe '#show' do
        it_should_behave_like 'unauthorized#show', :publisher, :Publisher
      end

      describe '#update' do
        it_should_behave_like 'unauthorized#update', :publisher, :Publisher
      end
    end

    context 'authorized' do
      describe '#create success' do
        it_should_behave_like 'authorized#create', :publisher, :Publisher, true
      end

      describe '#create fail' do
        it_should_behave_like 'authorized#create', :publisher, :Publisher, false
      end

      describe '#destory' do
        it_should_behave_like 'authorized#destroy', :publisher, :Publisher
      end

      describe '#edit' do
        it_should_behave_like 'authorized#edit', :publisher, :Publisher
      end

      describe '#index' do
        it_should_behave_like 'authorized#index', :publisher
      end

      describe '#new' do
        it_should_behave_like 'authorized#new', :publisher
      end

      describe '#show' do
        it_should_behave_like 'authorized#show', :publisher, :Publisher
      end

      describe '#update success' do
        it_should_behave_like 'authorized#update', :publisher, :Publisher, true
      end

      describe '#update fail' do
        it_should_behave_like 'authorized#update', :publisher, :Publisher, false
      end
    end
  end
end
