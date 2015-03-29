class UsersController < ApplicationController

  def profile
    user = current_user
    @conversations = Conversation.where("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", user.id, user.id)
    @dogs = Dog.where.not(user_id: current_user.id)
    @users_dogs = current_user.dogs
    @filters = user.filters
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
      flash[:notice] = "Profile successfully updated"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @dogs = @user.dogs
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
