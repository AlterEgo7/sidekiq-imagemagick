class CreateMontages < ActiveRecord::Migration[5.1]
  def change
    create_table :montages do |t|
      t.string :left_image
      t.string :right_image
      t.string :combined_image

      t.index :left_image
      t.index :right_image

      t.timestamps
    end
  end
end
