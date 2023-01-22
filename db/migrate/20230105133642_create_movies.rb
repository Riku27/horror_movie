class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.integer :genre_id, null: false
      t.integer :user_id, null: false
      t.string :title, null: false
      t.date :year, null: false
      t.string :director, null: false
      t.string :watch, null: false
      t.float :rate, null: false
      t.float :rate_horror, null: false
      t.timestamps
    end
  end
end
