class Size < Filter
  def filter(dogs)
    dogs.where({size:"#{content}"})
  end

  def self.options
    %w(Petite Small Medium Large Extra-Large)
  end
end
