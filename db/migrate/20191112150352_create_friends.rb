class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: true
      t.references :owner, foreign_key: {to_table: :posts}

      t.timestamps
    end
  end
end
