class Zipcode < Filter
  # def filter(dogs)
  #   dogs.where({zipcode: content.to_i})
  # end

  def filter(dogs)
    dogs.where("zipcode/10 = #{content}/10")
  end

end
