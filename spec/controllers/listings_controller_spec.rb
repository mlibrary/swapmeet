# frozen_string_literal: true

require "rails_helper"

RSpec.describe ListingsController, type: :controller do

  let(:user) { create(:user) }

  before(:each) do
    session[:user_id] = user.id
  end

  after(:each) do
    if assigns(:listing).image && File.exist?(assigns(:listing).image_path)
      FileUtils.rm assigns(:listing).image_path
    end
  end

  describe "POST #create" do

    let(:category) { create(:category) }
    let(:attributes) do
      attributes_for(:listing, category_id: category.id)
    end

    it "saves an uploaded image" do
      Tempfile.open(['whatever', '.jpg']) do |tempfile|
        post :create, params: { listing: attributes.merge(image: fixture_file_upload(tempfile, 'image/jpeg')) }
      end
      expect(File.exist?(assigns(:listing).image_path)).to be(true)
    end

    it "has an error with an 'image' with mimetype text/plain" do
      Tempfile.open(['whatever', '.txt']) do |tempfile|
        post :create, params: { listing: attributes.merge(image: fixture_file_upload(tempfile, 'text/plain')) }
      end
      expect(assigns(:listing).errors).to include(:image)
    end

    it "does not save the 'image' with mimetype text/plain" do
      Tempfile.open(['whatever', '.txt']) do |tempfile|
        post :create, params: { listing: attributes.merge(image: fixture_file_upload(tempfile, 'text/plain')) }
      end
      expect(assigns(:listing).image).to be(nil)
    end
  end

  describe "PATCH #edit" do

    context "with a listing with no image" do
      let(:listing) { create(:listing, owner: user) }

      it "can attach an image to an existing item" do
        Tempfile.open(['whatever', '.jpg']) do |tempfile|
          patch :update, params: { id: listing.id, listing: { image: fixture_file_upload(tempfile, 'image/jpeg') } }
        end
        expect(File.exist?(assigns(:listing).image_path)).to be(true)
      end
    end

    context "with a listing with an image" do
      let(:listing) { create(:listing, image: 'foo.jpg', owner: user) }

      it "keeps the existing image if a text file was uploaded" do
        Tempfile.open(['whatever', '.txt']) do |tempfile|
          patch :update, params: { id: listing.id, listing: { image: fixture_file_upload(tempfile, 'text/plain') } }
        end

        expect(assigns(:listing).image).to eq('foo.jpg')
      end
    end
  end

end
