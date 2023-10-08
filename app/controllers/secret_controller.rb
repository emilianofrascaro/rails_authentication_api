class SecretController < ApplicationController

    before_action :authenticate_user!

    def show
        user = get_user_from_token
        render json: {
            message: "if you see this, you're in!",
            user: user
        }
    end

    

end
