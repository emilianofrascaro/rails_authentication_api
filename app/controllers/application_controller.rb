class ApplicationController < ActionController::API

    rescue_from JWT::VerificationError, with: :user_not_logged_in

    private 
    def get_user_from_token
        error_code = false
        if request.headers['Authorization']!=nil
                jwt_payload = JWT.decode(request.headers["Authorization"].split(' ')[1], Rails.application.credentials.devise[:jwt_secret_key]).first
                user_id = jwt_payload['sub']
                user = User.find(user_id.to_s)    
        else
            raise JWT::VerificationError.new "Token Authorization not found!"
        end
        current_user = user
    end

    def user_not_logged_in
        render json: {
            message: "You are not logged in!",
            status: :unauthorized
        }, status: :unauthorized 
    end

end
