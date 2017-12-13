# frozen_string_literal: true

module ControllersHelper
  class AuthorizePolicy
    def create?; true; end
    def edit?; true; end
    def destroy?; true; end
    def index?; true; end
    def new?; true; end
    def show?; true; end
    def update?; true; end
    def authorize!(action, message = nil); end
  end
  class UnauthorizePolicy
    def create?; false; end
    def edit?; false; end
    def destroy?; false; end
    def index?; false; end
    def new?; false; end
    def show?; false; end
    def update?; false; end
    def authorize!(action, message = nil); raise NotAuthorizedError.new(message); end
  end
end

#
# Unauthorized
#

RSpec.shared_examples 'unauthorized#create' do |model, klass|
  subject { post :create, params: { model => attributes_for(model) } }
  controller do
    def set_policy
      @policy = ControllersHelper::UnauthorizePolicy.new
    end
  end
  before { subject }
  it "create #{model} unauthorized" do
    expect(response).to be_unauthorized
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'unauthorized#destroy' do |model, klass|
  subject { delete :destroy, params: { id: target.id } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::UnauthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "destroy #{model} unauthorized" do
    expect(response).to be_unauthorized
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'unauthorized#edit' do |model, klass|
  subject { get :edit, params: { id: target.id } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::UnauthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "edit #{model} unauthorized" do
    expect(response).to be_unauthorized
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'unauthorized#index' do |model|
  subject { get :index }
  controller do
    def set_policy
      @policy = ControllersHelper::UnauthorizePolicy.new
    end
  end
  before { subject }
  it "index #{model} unautorized" do
    expect(response).to be_unauthorized
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'unauthorized#new' do |model|
  subject { get :new }
  controller do
    def set_policy
      @policy = ControllersHelper::UnauthorizePolicy.new
    end
  end
  before { subject }
  it "new #{model} unauthorized" do
    expect(response).to be_unauthorized
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'unauthorized#show' do |model, klass|
  subject { get :show, params: { id: target.id } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::UnauthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "show #{model} unauthorized" do
    expect(response).to be_unauthorized
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'unauthorized#update' do |model, klass|
  subject { post :update, params: { id: target.id, model => attributes_for(model) } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::UnauthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "update #{model} unauthorized" do
    expect(response).to be_unauthorized
    response_check if respond_to?(:response_check)
  end
end

#
# Authorized
#

RSpec.shared_examples 'authorized#create' do |model, klass|
  subject { post :create, params: { model => attributes_for(model) } }
  controller do
    def set_policy
      @policy = ControllersHelper::AuthorizePolicy.new
    end
  end
  before { subject }
  it "create #{model} authorized" do
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to send("#{model}_path", klass.to_s.classify.constantize.last)
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'authorized#destroy' do |model, klass|
  subject { delete :destroy, params: { id: target.id } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::AuthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "destroy #{model} authorized" do
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to send("#{model}s_path")
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'authorized#edit' do |model, klass|
  subject { get :edit, params: { id: target.id } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::AuthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "edit #{model} authorized" do
    expect(response).to be_success
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'authorized#index' do |model|
  subject { get :index }
  controller do
    def set_policy
      @policy = ControllersHelper::AuthorizePolicy.new
    end
  end
  before { subject }
  it "index #{model} autorized" do
    expect(response).to be_success
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'authorized#new' do |model|
  subject { get :new }
  controller do
    def set_policy
      @policy = ControllersHelper::AuthorizePolicy.new
    end
  end
  before { subject }
  it "new #{model} authorized" do
    expect(response).to be_success
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'authorized#show' do |model, klass|
  subject { get :show, params: { id: target.id } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::AuthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "show #{model} authorized" do
    expect(response).to be_success
    response_check if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'authorized#update' do |model, klass|
  subject { post :update, params: { id: target.id, model => attributes_for(model) } }
  let(:target) { build(model, id: 1) }
  controller do
    def set_policy
      @policy = ControllersHelper::AuthorizePolicy.new
    end
  end
  before do
    allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    subject
  end
  it "update #{model} authorized" do
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to send("#{model}_path", target)
    response_check if respond_to?(:response_check)
  end
end
