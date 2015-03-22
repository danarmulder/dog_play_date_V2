class AddAvatarToNewDogsTable < ActiveRecord::Migration
  def change
    add_column :dogs, :avatar, :string
  end
end
