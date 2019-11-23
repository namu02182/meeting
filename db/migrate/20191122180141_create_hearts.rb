class CreateHearts < ActiveRecord::Migration[5.2]
  def change
    create_table :hearts do |t|
      # t.references :user, foreign_key: true
      # t.references :email, foreign_key: {to_table: :users}
      # t.references :post, foreign_key: true
      
      t.integer :user_id
      t.integer :lover_id
      t.integer :host_id

      t.timestamps
    end
  end
end
