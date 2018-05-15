# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Listing do
  subject(:listing) { Listing.new }

  describe "#new" do
    it "starts with blank attributes" do
      expect(listing.id)   .to be_nil
      expect(listing.title).to be_nil
      expect(listing.body) .to be_nil
    end
  end

  it "supports setting and reading the title" do
    listing.title = 'Onyx Chop Sticks'
    expect(listing.title).to eq('Onyx Chop Sticks')
  end

  it "supports setting and reading the body" do
    listing.body = 'A fine pair of chop sticks, made of pure onyx.'
    expect(listing.body).to eq('A fine pair of chop sticks, made of pure onyx.')
  end

  describe "#add_image!" do
    let(:old_file) { Rails.root.join("public","images","oldfile.png") }

    around(:each) do |example|
      Tempfile.open(['tempfile','.gif']) do |tempfile|
        @src_path = tempfile
        example.run
      end
    end

    after(:each) do 
      FileUtils.rm(listing.image_path) if File.exist?(listing.image_path)
    end

    it "copies the image to the expected destination" do
      listing.add_image!(@src_path)
      expect(File.exist?(listing.image_path)).to be true
    end

    it "saves the filename with a uuid" do
      listing.add_image!(@src_path)
      expect(listing.image).to match(/^[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}\.gif$/)
    end

    it "removes the old image when adding a new one" do
      listing.image = File.basename(old_file)
      FileUtils.touch(old_file)
      listing.add_image!(@src_path)
      expect(File.exist?(old_file)).to be false
    end
  end
end
