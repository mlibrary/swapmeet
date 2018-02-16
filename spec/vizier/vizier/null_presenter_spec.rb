# frozen_string_literal: true

require 'vizier/null_presenter'

RSpec.describe Vizier::NullPresenter do

  subject(:presenter) { described_class.new(object, double('View')) }

  it 'delegates to the presented object' do
    expect(presenter.__getobj__).to eq object
    expect(presenter.foo). to eq 'bar'
  end

  def object
    @object ||= double('To Be Presented', foo: 'bar')
  end
end
