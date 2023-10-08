class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def sign_up_params
        puts params.inspect
        params.require(:user).permit(
          :email,
          :password,
          :password_confirmation)
      end

    def respond_with(resource, _opts = {})
        puts resource.inspect
        register_success &&  return if resource.persisted?

        register_failed
    end

    def register_success
        render json: {
            message: 'Signed up successfully',
            user: current_user
        }, status: :ok
    end

    def register_failed
        render json: { message: 'Something went wrong.' },
        status: :unprocessable_entity
    end

end