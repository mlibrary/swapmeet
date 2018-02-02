class AddOwnerToListing < ActiveRecord::Migration[5.1]
  def change
    add_reference :listings, :owner, foreign_key: { to_table: :users }
  end
end