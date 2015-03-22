class AddAvatarToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :avatar, :string
  end
end
