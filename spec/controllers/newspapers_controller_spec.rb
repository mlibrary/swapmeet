# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewspapersController, type: :controller do
  context 'policy enforcement' do
    let(:publisher) { create(:publisher, id: '1') }
    before { allow(Publisher).to receive(:find).with("1").and_return(publisher) }
    it_should_behave_like 'policy enforcer', :newspaper, :Newspaper, "name": "Name", "display_name": "Display Name", "publisher_id": "1"
  end

  describe '#new_policy' do
    it { expect(subject.send(:new_policy)).to be_a(NewspapersPolicy) }
  end
end
