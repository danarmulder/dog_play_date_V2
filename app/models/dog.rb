class Dog < ActiveRecord::Base
  validates :name, :gender, :age, presence: true
  belongs_to :user

  mount_uploader :avatar, DogUploader
end
