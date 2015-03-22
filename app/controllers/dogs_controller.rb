class DogsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :destroy, :edit]
  def new
    @dog = current_user.dogs.new
  end

  def create
    @dog = current_user.dogs.new(dog_params)
    @dog.zipcode = current_user.zipcode
    if @dog.save
      redirect_to preferences_path
    else
      render :new
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    @dog.update(dog_params)
    if @dog.save
      redirect_to profile_path
    else
      render :edit
      flash[:notice] = "Dog could not be updated"
    end
  end

  def destroy
    @dog=Dog.find(params[:id])
    @dog.destroy
    redirect_to profile_path
    flash[:notice] = "Dog successfully removed from your family"
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
      :avatar,
      :user_id,
      :zipcode)
    end
end
