class RegistrationController < ApplicationController
  require 'rest-client'
  require 'json'
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_dog_path
      filter = @user.filters.new({type: "Zipcode", content: @user.zipcode.to_s})
      filter.save
    else
      render :new
      flash[:alert]= "User could not be signed up"
    end
    response = RestClient.post "https://maps.googleapis.com/maps/api/geocode/json?address=" + @user.zipcode.to_s + "&key=" + GOOGLE_API_KEY
      json = JSON.parse(response)
      session[:location] = json[results][geometry][location]
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :zipcode,
      :age,
      :bio,
      :gender,
      :avatar,
      :password,
      :password_confirmation
    )
  end
end
