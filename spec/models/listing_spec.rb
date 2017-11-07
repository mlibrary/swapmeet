require 'listing'

RSpec.describe Listing do

  describe "#new" do
    it "does not set an ID" do
      expect(subject.id).to be_nil
    end
  end

  it "has a title" do
    expect(subject.title).to eq 'Onyx Chop Sticks'
  end

  it "has a body" do
    expect(subject.body).to eq 'A fine pair of chop sticks, made of pure onyx.'
  end
end
