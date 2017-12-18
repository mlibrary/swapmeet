class AddCategoryToListing < ActiveRecord::Migration[5.1]
  def change
    add_reference :listings, :category, foreign_key: true
  end
end
