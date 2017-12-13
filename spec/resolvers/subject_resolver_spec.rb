require 'subject_resolver'

RSpec.describe SubjectResolver do

  context "with a known user" do
    let(:bill) { double('User', username: 'bill', known?: true) }
    let(:bob)  { double('User', username: 'bob', known?: true) }
    let(:jane) { double('User', username: 'jane', known?: true) }

    it "resolves User `bill`'s token" do
      resolver = SubjectResolver.new(bill)
      expect(resolver.resolve).to eq ['user:bill', 'affiliation:faculty']
    end

    it "resolves User `bob`'s token" do
      resolver = SubjectResolver.new(bob)
      expect(resolver.resolve).to eq ['user:bob', 'affiliation:lib-staff']
    end

    it "resolves User `jane`'s token" do
      resolver = SubjectResolver.new(jane)
      expect(resolver.resolve).to eq ['user:jane', 'affiliation:lib-staff', 'affiliation:faculty']
    end
  end
end
