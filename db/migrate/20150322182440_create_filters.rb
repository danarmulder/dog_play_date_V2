class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :type
      t.string :content
      t.integer :user_id
      t.timestamps
    end
  end
end
