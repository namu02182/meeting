class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.datetime :dateofbirth
      t.text :content
      t.string :owner_id
      t.string :sex
      t.string :home
      t.string :job
      t.string :workplace
      t.integer :height
      t.timestamps
    end
  end
end
