class Gender < Filter
  def filter(dogs)
    dogs.where({gender: "#{content}"})
  end
end
