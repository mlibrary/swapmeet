class AddImageToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :image, :string
  end
end
