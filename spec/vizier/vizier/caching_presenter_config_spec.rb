# frozen_string_literal: true

require 'support/presenter_config_fakes'
require 'vizier/caching_presenter_config'

RSpec.describe Vizier::CachingPresenterConfig do
  # These specs all have two equivalent expectations for clarity: that the
  # config does not give the newly reassigned class through constant lookup.

  describe '#type' do
    around(:each) do |example|
      type = resolve_class('FakeType')
      example.run
      redefine_class('FakeType', type)
    end

    it 'caches the class given' do
      config = build_config
      type1 = config.type
      redefine_class('FakeType', OtherFakeType)
      type2 = config.type

      expect(type1).to eq type2
      expect(type1).not_to eq OtherFakeType
    end
  end

  describe '#presenter' do
    around(:each) do |example|
      presenter = resolve_class('FakePresenter')
      example.run
      redefine_class('FakePresenter', presenter)
    end

    it 'caches the class given' do
      config = build_config
      presenter1 = config.presenter
      redefine_class('FakePresenter', OtherFakePresenter)
      presenter2 = config.presenter

      expect(presenter1).to eq presenter2
      expect(presenter1).not_to eq OtherFakePresenter
    end
  end

  describe '#policy' do
    around(:each) do |example|
      policy = resolve_class('FakePolicy')
      example.run
      redefine_class('FakePolicy', policy)
    end

    it 'caches the class given' do
      config = build_config
      policy1 = config.policy
      redefine_class('FakePolicy', OtherFakePolicy)
      policy2 = config.policy

      expect(policy1).to eq policy2
      expect(policy1).not_to eq OtherFakePolicy
    end
  end

  def build_config
    described_class.new(FakeType, FakePresenter, FakePolicy)
  end

  def resolve_class(name)
    Object.const_get(name)
  end

  def redefine_class(name, klass)
    Object.send(:remove_const, name)
    Object.const_set(name, klass)
  end
end
