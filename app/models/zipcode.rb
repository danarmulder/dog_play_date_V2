class Zipcode < Filter
  def filter(dogs)
    dogs.where({zipcode: content.to_i})
  end

end
