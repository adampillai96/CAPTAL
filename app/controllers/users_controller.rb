class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            flash[:success] = "You've successfully created your account"
            redirect_to new_user_path
        else
            flash[:danger] = @user.errors.full_messages
            redirect_to new_user_path

        end
  end

    def edit
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])

        if @user.update(user_params)
            flash[:success] = "You've successfully updated your account."
            redirect_to root_path(@user)
        else
            flash[:danger] = @user.errors.full_messages
            redirect_to user_path(@user)
        end
    end

    def destroy
        @user = user.find_by(id: params[:id])
        if @user.destroy
            flash[:success] = "You've successfully deleted your user."
            redirect_to users_path
        else
            redirect_to user_path(@user)
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :username, :image)
      end
        end
