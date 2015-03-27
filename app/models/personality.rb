class Personality < Filter
  def filter(dogs)
    dogs.where({personality: "#{content}"})
  end

  def self.options
    %w(Confident Independent Laid-Back Shy-Timid Adaptable)
  end
end
