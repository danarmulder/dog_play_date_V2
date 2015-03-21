class Dog < ActiveRecord::Base
  validates :name, :gender, :age, presence: true
  belongs_to :user
end
