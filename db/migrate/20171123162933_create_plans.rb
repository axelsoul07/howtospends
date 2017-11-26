class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :address
      t.string :content
      t.string :money
      t.integer :status
      t.string :friendly_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
