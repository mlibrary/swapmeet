require 'grant_resolver'

RSpec.describe GrantResolver do

  let(:anna) { double('User', username: 'anna') }
  let(:katy) { double('User', username: 'katy') }
  let(:edit) { :edit }
  let(:listing) { double('Listing', id: 17, entity_type: 'listing') }

  describe "#any?" do

    it "finds a grant for Anna to edit listing 17" do
      resolver = GrantResolver.new(anna, edit, listing)
      expect(resolver.any?).to be true
    end

    it "does not find a grant for Katy to edit listing 17" do
      resolver = GrantResolver.new(katy, edit, listing)
      expect(resolver.any?).to be false
    end
  end

end
