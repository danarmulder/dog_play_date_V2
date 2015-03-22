class BlockedUser < Filter
  def filter(dogs)
    dogs  = dogs.where.not({user_id: content.to_i})
  end
end
