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
# Policy Enforcement
#
RSpec.shared_examples 'policy enforcer' do |model, klass, attrs = nil |
  describe "#{model} unautorized" do
    controller do
      def set_policy
        @policy = ControllersHelper::UnauthorizePolicy.new
      end
    end

    before do
      attrs ||= attributes_for(model)
      allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(nil)
    end

    it '#index' do
      get :index
      expect(response).to be_unauthorized
    end

    it '#show' do
      get :show, params: { id: '1' }
      expect(response).to be_unauthorized
    end

    it '#new' do
      get :new
      expect(response).to be_unauthorized
    end

    it '#edit' do
      get :edit, params: { id: '1' }
      expect(response).to be_unauthorized
    end

    it '#create' do
      post :create, params: { model => attrs }
      expect(response).to be_unauthorized
    end

    it '#update' do
      post :update, params: { id: '1', model => attrs }
      expect(response).to be_unauthorized
    end

    it '#destroy' do
      delete :destroy, params: { id: '1' }
      expect(response).to be_unauthorized
    end
  end

  describe "#{model} authorized" do
    let(:target) { build(model, id: 1) }

    controller do
      def set_policy
        @policy = ControllersHelper::AuthorizePolicy.new
      end
    end

    before do
      controller.instance_variable_set("@#{model}", target)
      allow(klass.to_s.classify.constantize).to receive(:find).with('1').and_return(target)
    end

    it '#index' do
      get :index
      expect(response).to be_success
    end

    it '#show' do
      get :show, params: { id: '1' }
      expect(response).to be_success
    end

    it '#new' do
      get :new
      expect(response).to be_success
    end

    it '#edit' do
      get :edit, params: { id: '1' }
      expect(response).to be_success
    end

    it '#create' do
      post :create, params: { model => attrs }
      expect(response).to have_http_status(:found)
    end

    it '#update' do
      post :update, params: { id: '1', model => attrs }
      expect(response).to have_http_status(:found)
    end

    it '#destroy' do
      delete :destroy, params: { id: '1' }
      expect(response).to have_http_status(:found)
    end
  end
end
