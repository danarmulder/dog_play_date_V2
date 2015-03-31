class Gender < Filter
  validate :user_cannot_have_more_than_one_gender_filter

  def filter(dogs)
    dogs.where({gender: "#{content}"})
  end

  def user_cannot_have_more_than_one_gender_filter
    if Filter.where(user_id: user_id, type: "Gender").exists?
      errors.add(:user_id, "Cannot have more than one gender preference")
    end
  end
end
