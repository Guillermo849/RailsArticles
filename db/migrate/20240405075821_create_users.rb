class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :surname
      t.integer :age

      t.timestamps
    end
  end
end
