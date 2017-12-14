require 'user_directory'

RSpec.describe UserDirectory do
  describe "#attributes_for" do
    let(:user) { double('User') }
    subject(:directory) { UserDirectory.new }

    it "gives an empty attribute hash" do
      expect(directory.attributes_for(user)).to eq({})
    end
  end
end
