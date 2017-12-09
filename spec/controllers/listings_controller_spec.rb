# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingsController do
  context 'policy' do
    context 'unauthorized' do
      describe '#create' do
        it_should_behave_like 'unauthorized#create', :listing, :Listing
      end

      describe '#destory' do
        it_should_behave_like 'unauthorized#destroy', :listing, :Listing
      end

      describe '#edit' do
        it_should_behave_like 'unauthorized#edit', :listing, :Listing
      end

      describe '#index' do
        it_should_behave_like 'unauthorized#index', :listing
      end

      describe '#new' do
        it_should_behave_like 'unauthorized#new', :listing
      end

      describe '#show' do
        it_should_behave_like 'unauthorized#show', :listing, :Listing
      end

      describe '#update' do
        it_should_behave_like 'unauthorized#update', :listing, :Listing
      end
    end

    context 'authorized' do
      describe '#create' do
        before do
          allow(User).to receive(:guest).and_return(nil)
        end
        it_should_behave_like 'authorized#create', :listing, :Listing
      end

      describe '#destory' do
        it_should_behave_like 'authorized#destroy', :listing, :Listing
      end

      describe '#edit' do
        it_should_behave_like 'authorized#edit', :listing, :Listing
      end

      describe '#index' do
        it_should_behave_like 'authorized#index', :listing
      end

      describe '#new' do
        it_should_behave_like 'authorized#new', :listing
      end

      describe '#show' do
        it_should_behave_like 'authorized#show', :listing, :Listing
      end

      describe '#update' do
        it_should_behave_like 'authorized#update', :listing, :Listing
      end
    end
  end
end
