# frozen_string_literal: true

require 'vizier/collection_presenter'
require 'vizier/null_presenter'

RSpec.describe Vizier::CollectionPresenter do
  context 'with a policy that does not allow any items' do
    it 'reports empty' do
      presenter = without_items
      expect(presenter.empty?).to be true
    end

    it 'iterates over nothing with .each' do
      presenter = without_items
      items = []
      presenter.each { |item| items << item }
      expect(items).to be_empty
    end
  end

  context 'with a policy granting access to items' do
    it 'reports not empty' do
      items = [double(name: 'item1'), double(name: 'item2')]
      presenter = with_items(items)
      expect(presenter.empty?).to be false
    end

    it 'supports .each over the items and presents them' do
      items = [double(name: 'item1'), double(name: 'item2')]
      presenter = with_items(items)
      items = []
      presenter.each { |item| items << item }

      expect(items).to all be_a(Vizier::NullPresenter)
    end

    it 'supports .map over items and preserves order' do
      items = [double(name: 'item1'), double(name: 'item2')]
      presenter = with_items(items)

      expect(presenter.map(&:name)).to eq(['item1', 'item2'])
    end
  end

  def build_presenter(policy)
    Vizier::CollectionPresenter.new(
      policy,
      double('view'),
      presenter_factory: factory
    )
  end

  def factory
    double('factory').tap do |factory|
      allow(factory).to receive(:[]) do |resource, user, view|
        Vizier::NullPresenter.new(resource)
      end
    end
  end

  def without_items
    policy = double('CollectionPolicy', user: double('user'), resolve: [])
    build_presenter(policy)
  end

  def with_items(items)
    policy = double('CollectionPolicy', user: double('user'), resolve: items)
    build_presenter(policy)
  end
end
