# frozen_string_literal: true

require 'ostruct'
require 'vizier/presenter_config'

RSpec.describe Vizier::PresenterConfig do
  class Type; end
  class Presenter < Struct.new(:policy, :view); end
  class Policy < Struct.new(:user, :object); end

  describe '#type' do
    context 'when a class was given' do
      it 'returns it' do
        config = class_config
        expect(config.type).to eq Type
      end
    end

    context 'when a string was given' do
      it 'resolves the class' do
        config = class_config
        expect(config.type).to eq Type
      end
    end
  end

  describe '#presenter' do
    context 'when a class was given' do
      it 'returns it' do
        config = class_config
        expect(config.presenter).to eq Presenter
      end
    end

    context 'when a string was given' do
      it 'resolves the class' do
        config = class_config
        expect(config.presenter).to eq Presenter
      end
    end
  end

  describe '#policy' do
    context 'when a class was given' do
      it 'returns it' do
        config = class_config
        expect(config.policy).to eq Policy
      end
    end

    context 'when a string was given' do
      it 'resolves the class' do
        config = class_config
        expect(config.policy).to eq Policy
      end
    end
  end

  describe '#present' do
    let(:object) { double('Object') }
    let(:user)   { double('User') }
    let(:view)   { double('View') }

    subject(:presenter) { presenter = class_config.present(object, user, view) }

    it 'uses the configured presenter class for the presenter' do
      expect(presenter).to be_a Presenter
    end

    it 'uses the configured policy class on the presenter' do
      expect(presenter.policy).to be_a Policy
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

  def class_config
    described_class.new(Type, Presenter, Policy)
  end

  def string_config
    described_class.new('Type', 'Presenter', 'Policy')
  end
end
