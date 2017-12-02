class Listing < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  def owner
    super || User.nobody
  end
end
