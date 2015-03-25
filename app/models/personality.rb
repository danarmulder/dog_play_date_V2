class Personality < Filter
  def filter(dogs)
    dogs.where({personality: "#{content}"})
  end

  def self.options
    %w(Confident Independent LaidBack ShyTimid Adaptable)
  end
end
