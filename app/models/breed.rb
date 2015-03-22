class Breed < Filter
  def filter(dogs)
    dogs.where({breed: "#{content}"})
  end
end
