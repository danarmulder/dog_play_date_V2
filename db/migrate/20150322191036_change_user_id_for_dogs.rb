class ChangeUserIdForDogs < ActiveRecord::Migration
  def change
    drop_table :dogs
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :age
      t.string :size
      t.string :gender
      t.string :personality
      t.string :play
      t.string :bio
      t.integer :user_id

      t.timestamps
    end
  end
end
