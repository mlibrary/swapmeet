class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :body
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
