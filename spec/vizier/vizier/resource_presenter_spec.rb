# frozen_string_literal: true

require 'vizier/resource_presenter'

RSpec.describe Vizier::ResourcePresenter do
  it 'delegates to the resource' do
    presenter = build_presenter
    expect(presenter.name).to be 'a name'
  end

  def build_presenter
    resource = double('Resource', name: 'a name')
    policy   = double('Policy', resource: resource)
    view     = double('View')
    described_class.new(policy, view, presenter_factory: double())
  end
end
