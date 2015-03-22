class AddZipcodeColumnToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :zipcode, :integer
  end
end
