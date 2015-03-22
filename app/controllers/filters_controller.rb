class FiltersController < ApplicationController
  def index
    @filters = current_user.filters
    @dogs = Dog.all
    @filters.each do |filter|
      @dogs = filter.filter(@dogs)
    end
    
    @filter = @filters.new
  end
end
