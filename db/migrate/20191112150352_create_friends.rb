class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      # t.references :user, foreign_key: true
      # t.references :owner, foreign_key: {to_table: :posts}
      t.integer :user_id
      t.integer :owner_id
      t.timestamps
    end
  end
end
