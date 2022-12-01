class UsersController < ApplicationController
    # before_action :authorize,  only [:show]
    def create
        user = User.create(user_params)
        if user.valid? 
            session[:user_id] = user.id
            render json: user
        else
            render  json: {error: "unprocessed entity"}, status: 422
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
        render json: user
        else 
            render json: {error: "Unathorized"}, status: 401
      end
    end

    private

    # def authorize
    #     return render json: {error: "unauthorized"}, status: 401 unless session.includes? :user_id
    # end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
