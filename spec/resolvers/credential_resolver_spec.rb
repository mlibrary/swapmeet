require 'credential_resolver'

RSpec.describe CredentialResolver do
  let(:edit) { :edit }
  let(:read) { :read }

  it "resolves edit to 'permission:edit'" do
    resolver = CredentialResolver.new(edit)
    expect(resolver.resolve).to eq 'permission:edit'
  end

  it "resolves read to 'permission:read'" do
    resolver = CredentialResolver.new(read)
    expect(resolver.resolve).to eq 'permission:read'
  end

  it "accepts string actions" do
    resolver = CredentialResolver.new('read')
    expect(resolver.resolve).to eq 'permission:read'
  end

  it "accepts symbol actions" do
    resolver = CredentialResolver.new(:read)
    expect(resolver.resolve).to eq 'permission:read'
  end
end
