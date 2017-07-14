class CreateMontages < ActiveRecord::Migration[5.1]
  def change
    create_table :montages do |t|
      t.string :left_image
      t.string :right_image
      t.string :combined_image
      t.string :hash_code, unique: true

      t.index :hash_code

      t.timestamps
    end
  end
end
