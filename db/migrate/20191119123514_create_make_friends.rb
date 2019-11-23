class CreateMakeFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :make_friends do |t|
      t.string :name
      t.string :sex
      t.string :age
      t.string :home
      t.string :job
      t.string :workplace
      t.integer :height
      t.text :selfintroduction
      t.text :comment
      t.string :religion
      t.string :smoking
      t.integer :drink
      t.integer :mind
      t.string :phone
      t.string :owner_id
      t.string :user_id, foreign_key: true
      t.timestamps
    end
  end
end
