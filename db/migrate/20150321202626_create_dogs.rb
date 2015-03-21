class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :age
      t.string :size
      t.string :gender
      t.string :personality
      t.string :play
      t.string :bio
      t.string :user_id

      t.timestamps
    end
  end
end
