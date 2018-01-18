# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrivilegesController, type: :controller do
  it { is_expected.to be_a(PrivilegesController) }

  describe '#new_policy' do
    it { expect(subject.send(:new_policy)).to be_a(PrivilegesPolicy) }
  end
end
