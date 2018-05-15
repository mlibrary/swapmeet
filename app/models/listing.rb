# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :category

  def add_image!(path)
    FileUtils.rm(image_path) if image and File.exists?(image_path)
    self.image = "#{SecureRandom.uuid}#{File.extname(path)}"
    FileUtils.copy(path,image_path)
  end

  def image_path
    Rails.root.join("public","images",image)
  end

end
