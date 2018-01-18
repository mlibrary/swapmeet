# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  it_should_behave_like 'policy enforcer', :group, :Group

  describe '#new_policy' do
    it { expect(subject.send(:new_policy)).to be_a(GroupsPolicy) }
  end
end
