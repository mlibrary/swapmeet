# frozen_string_literal: true

# See the fakes for usage examples
require 'support/resource_presenter_fakes'
require 'vizier/presenter_factory'
require 'vizier/read_only_policy'
require 'vizier/null_presenter'

RSpec.describe Vizier::PresenterFactory do

  context 'when not supplying a mapping' do
    it 'uses the NullPresenter' do
      factory = default_factory
      presenter = factory[double('object'), double('user'), double('view')]
      expect(presenter).to be_a Vizier::NullPresenter
    end

    it 'wraps the object in a ReadOnlyPolicy' do
      factory   = default_factory
      user      = double('user')
      object    = double('object')
      presenter = factory[object, user, double('view')]
      policy    = presenter.__getobj__

      expect(policy).to be_a Vizier::ReadOnlyPolicy
      expect(policy.user).to eq(user)
      expect(policy.resource).to eq(object)
    end
  end

  # This is more of an integration test to show usage than a unit test.
  context 'when subclassing for application needs' do
    context 'when an object type is not mapped' do
      it 'uses the NullPresenter' do
        factory = configured_factory
        presenter = factory[double('object'), double('user'), double('view')]
        expect(presenter).to be_a Vizier::NullPresenter
      end

      it 'wraps the object in a ReadOnlyPolicy' do
        factory   = configured_factory
        user      = double('user')
        object    = double('object')
        presenter = factory[object, user, double('view')]
        policy    = presenter.__getobj__

        expect(policy).to be_a Vizier::ReadOnlyPolicy
        expect(policy.user).to eq(user)
        expect(policy.resource).to eq(object)
      end
    end

    describe 'a specific resource presenter' do
      it 'transforms a property' do
        # See SomeResourcePresenter, the fake behavior is to upcase name
        resource = SomeResource.new('a name', double('other resource'))
        presenter = build_specific_presenter(resource)
        expect(presenter.name).to eq 'A NAME'
      end

      it 'allows create?, according to configured policy' do
        resource = SomeResource.new('a name', double('other resource'))
        presenter = build_specific_presenter(resource)
        expect(presenter.create?).to be true
      end

      describe 'with associated objects' do
        it 'uses the configured presenter' do
          other = OtherResource.new('a long title')
          resource = SomeResource.new('name', other)
          presenter = build_specific_presenter(resource)

          expect(presenter.other_resource).to be_a(OtherResourcePresenter)
        end

        it 'presents with transformation methods available' do
          other = OtherResource.new('a long title')
          resource = SomeResource.new('name', other)
          presenter = build_specific_presenter(resource)
          other_presenter = presenter.other_resource

          expect(other_presenter.short_title).to eq 'a long...'
        end

        it 'disallows edit?, according to the configured policy' do
          other = OtherResource.new('a long title')
          resource = SomeResource.new('name', other)
          presenter = build_specific_presenter(resource)
          other_presenter = presenter.other_resource

          expect(other_presenter.edit?).to be false
        end
      end
    end
  end

  def default_factory
    Vizier::PresenterFactory.new
  end

  def configured_factory
    FakePresenterFactory.instance
  end

  def build_specific_presenter(resource)
    policy = SomeResourcePolicy.new(double('User'), resource)
    SomeResourcePresenter.new(policy, double('View'))
  end

  def build_generic_presenter(resource)
    policy = double('policy', resource: resource)
    AppResourcePresenter.new(policy, double('View'))
  end
end
