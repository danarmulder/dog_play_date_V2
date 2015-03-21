class DogsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :destroy, :edit]
  def new
    @dog = current_user.dogs.new
  end

  def create
    @dog = current_user.dogs.new(dog_params)
    if @dog.save
      redirect_to profile_path
    else
      render :new
    end
  end

  private
    def dog_params
      params.require(:dog).permit(
      :name,
      :breed,
      :gender,
      :age,
      :size,
      :play,
      :personality,
      :bio,
      :user_id)
    end
end
