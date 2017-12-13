require 'grant_resolver'

RSpec.describe GrantResolver do

  let(:anna)    { double('User', username: 'anna', known?: true) }
  let(:katy)    { double('User', username: 'katy', known?: true) }
  let(:guest)   { double('User', username: '<guest>', known?: false) }
  let(:edit)    { :edit }
  let(:read)    { :read }
  let(:listing) { double('Listing', id: 17, entity_type: 'listing') }

  context "for Anna (known user 1)" do
    it "finds a grant to edit listing 17" do
      resolver = GrantResolver.new(anna, edit, listing)
      expect(resolver.any?).to be true
    end

    it "finds a grant to read listing 17" do
      resolver = GrantResolver.new(anna, read, listing)
      expect(resolver.any?).to be true
    end
  end

  context "for Katy (known user 2)" do
    it "does not find a grant to edit listing 17" do
      resolver = GrantResolver.new(katy, edit, listing)
      expect(resolver.any?).to be false
    end

    it "finds a grant to read listing 17" do
      resolver = GrantResolver.new(katy, read, listing)
      expect(resolver.any?).to be true
    end
  end

  context "for a guest user" do
    it "does not find any grants to read listing 17" do
      resolver = GrantResolver.new(guest, read, listing)
      expect(resolver.any?).to eq false
    end

    it "does not find any grants to edit listing 17" do
      resolver = GrantResolver.new(guest, read, listing)
      expect(resolver.any?).to eq false
    end
  end

end
