class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :owner_id
      t.string :name
      t.string :image
      t.string :sex
      t.string :age
      t.string :status
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
      t.timestamps
    end
  end
end
