# frozen_string_literal: true

require 'support/presenter_config_fakes'
require 'vizier/presenter_config'

RSpec.describe Vizier::PresenterConfig do
  describe '#type' do
    context 'when a class was given' do
      it 'returns it' do
        config = class_config
        expect(config.type).to eq FakeType
      end
    end

    context 'when a string was given' do
      it 'resolves the class' do
        config = string_config
        expect(config.type).to eq FakeType
      end
    end

    context 'when reloading classes' do
      around(:each) do |example|
        type = resolve_class('FakeType')
        example.run
        redefine_class('FakeType', type)
      end

      it 'returns the new class' do
        config = class_config
        type1 = config.type
        redefine_class('FakeType', OtherFakeType)
        type2 = config.type

        expect(type1).not_to eq type2
        expect(type2).to eq OtherFakeType
      end
    end
  end

  describe '#presenter' do
    context 'when a class was given' do
      it 'returns it' do
        config = class_config
        expect(config.presenter).to eq FakePresenter
      end
    end

    context 'when a string was given' do
      it 'resolves the class' do
        config = string_config
        expect(config.presenter).to eq FakePresenter
      end
    end

    context 'when reloading classes' do
      around(:each) do |example|
        presenter = resolve_class('FakePresenter')
        example.run
        redefine_class('FakePresenter', presenter)
      end

      it 'returns the new class' do
        config = class_config
        presenter1 = config.presenter
        redefine_class('FakePresenter', OtherFakePresenter)
        presenter2 = config.presenter

        expect(presenter1).not_to eq presenter2
        expect(presenter2).to eq OtherFakePresenter
      end
    end
  end

  describe '#policy' do
    context 'when a class was given' do
      it 'returns it' do
        config = class_config
        expect(config.policy).to eq FakePolicy
      end
    end

    context 'when a string was given' do
      it 'resolves the class' do
        config = string_config
        expect(config.policy).to eq FakePolicy
      end
    end

    context 'when reloading classes' do
      around(:each) do |example|
        policy = resolve_class('FakePolicy')
        example.run
        redefine_class('FakePolicy', policy)
      end

      it 'returns the new class' do
        config = class_config
        policy1 = config.policy
        redefine_class('FakePolicy', OtherFakePolicy)
        policy2 = config.policy

        expect(policy1).not_to eq policy2
        expect(policy2).to eq OtherFakePolicy
      end
    end
  end

  describe '#present' do
    let(:object) { double('Object') }
    let(:user)   { double('User') }
    let(:view)   { double('View') }

    subject(:presenter) { presenter = class_config.present(object, user, view) }

    it 'uses the configured presenter class for the presenter' do
      expect(presenter).to be_a FakePresenter
    end

    it 'uses the configured policy class on the presenter' do
      expect(presenter.policy).to be_a FakePolicy
    end

    it 'sets the supplied view on the presenter' do
      expect(presenter.view).to eq view
    end

    it 'sets the supplied user on the policy' do
      expect(presenter.policy.user).to eq user

    end

    it 'sets the supplied object on the policy' do
      expect(presenter.policy.object).to eq object
    end
  end

  context 'while redefining/reloading classes' do
    it 'gives the new type' do
      config = class_config
      type1 = config.type
    end
  end

  def class_config
    described_class.new(FakeType, FakePresenter, FakePolicy)
  end

  def string_config
    described_class.new('FakeType', 'FakePresenter', 'FakePolicy')
  end

  def resolve_class(name)
    Object.const_get(name)
  end

  def redefine_class(name, klass)
    Object.send(:remove_const, name)
    Object.const_set(name, klass)
  end
end
