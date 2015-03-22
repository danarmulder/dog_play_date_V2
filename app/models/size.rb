class Size < Filter
  def filter(dogs)
    dogs.where({size:"#{content}"})
  end
end
