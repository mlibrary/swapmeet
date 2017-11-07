require 'repository'

RSpec.describe Repository do
  subject(:repo) { Repository }
  let(:foo) { double('Some Repo') }
  let(:bar) { double('Another Repo') }

  before(:each) do
    Repository.class_variable_set :@@registry, nil
  end

  it "starts empty" do
    expect(repo.registry).to eq({})
  end

  describe "#register" do
    it "adds a repository for a type" do
      subject.register(:foo, foo)
      expect(repo.registry).to eq({foo: foo})
    end
  end

  describe "#for" do
    it "locates a registered repository" do
      subject.register(:bar, bar)
      expect(repo.for(:bar)).to eq(bar)
    end

    it "raises for an unregistered repository" do
      expect {
        repo.for(:foo)
      }.to raise_error(RepositoryNotFoundError)
    end
  end
end
