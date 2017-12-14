# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  context 'policy' do
    context 'unauthorized' do
      describe '#create' do
        it_should_behave_like 'unauthorized#create', :group, :Group
      end

      describe '#destory' do
        it_should_behave_like 'unauthorized#destroy', :group, :Group
      end

      describe '#edit' do
        it_should_behave_like 'unauthorized#edit', :group, :Group
      end

      describe '#index' do
        it_should_behave_like 'unauthorized#index', :group
      end

      describe '#new' do
        it_should_behave_like 'unauthorized#new', :group
      end

      describe '#show' do
        it_should_behave_like 'unauthorized#show', :group, :Group
      end

      describe '#update' do
        it_should_behave_like 'unauthorized#update', :group, :Group
      end
    end

    context 'authorized' do
      describe '#create success' do
        it_should_behave_like 'authorized#create', :group, :Group, true
      end

      describe '#create fail' do
        it_should_behave_like 'authorized#create', :group, :Group, false
      end

      describe '#destory' do
        it_should_behave_like 'authorized#destroy', :group, :Group
      end

      describe '#edit' do
        it_should_behave_like 'authorized#edit', :group, :Group
      end

      describe '#index' do
        it_should_behave_like 'authorized#index', :group
      end

      describe '#new' do
        it_should_behave_like 'authorized#new', :group
      end

      describe '#show' do
        it_should_behave_like 'authorized#show', :group, :Group
      end

      describe '#update success' do
        it_should_behave_like 'authorized#update', :group, :Group, true
      end

      describe '#update fail' do
        it_should_behave_like 'authorized#update', :group, :Group, false
      end
    end
  end
end
