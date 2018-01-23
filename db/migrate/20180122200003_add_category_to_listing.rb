class AddCategoryToListing < ActiveRecord::Migration[5.1]
  def change
    add_reference :listings, :category
  end
end
