# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewspapersController, type: :controller do
  context 'policy' do
    context 'unauthorized' do
      describe '#create' do
        it_should_behave_like 'unauthorized#create', :newspaper, :Newspaper
      end

      describe '#destory' do
        it_should_behave_like 'unauthorized#destroy', :newspaper, :Newspaper
      end

      describe '#edit' do
        it_should_behave_like 'unauthorized#edit', :newspaper, :Newspaper
      end

      describe '#index' do
        it_should_behave_like 'unauthorized#index', :newspaper
      end

      describe '#new' do
        it_should_behave_like 'unauthorized#new', :newspaper
      end

      describe '#show' do
        it_should_behave_like 'unauthorized#show', :newspaper, :Newspaper
      end

      describe '#update' do
        it_should_behave_like 'unauthorized#update', :newspaper, :Newspaper
      end
    end

    context 'authorized' do
      describe '#create success' do
        it_should_behave_like 'authorized#create', :newspaper, :Newspaper, true
      end

      describe '#create fail' do
        it_should_behave_like 'authorized#create', :newspaper, :Newspaper, false
      end

      describe '#destory' do
        it_should_behave_like 'authorized#destroy', :newspaper, :Newspaper
      end

      describe '#edit' do
        it_should_behave_like 'authorized#edit', :newspaper, :Newspaper
      end

      describe '#index' do
        it_should_behave_like 'authorized#index', :newspaper
      end

      describe '#new' do
        it_should_behave_like 'authorized#new', :newspaper
      end

      describe '#show' do
        it_should_behave_like 'authorized#show', :newspaper, :Newspaper
      end

      describe '#update success' do
        it_should_behave_like 'authorized#update', :newspaper, :Newspaper, true
      end

      describe '#update fail' do
        it_should_behave_like 'authorized#update', :newspaper, :Newspaper, false
      end
    end
  end
end
