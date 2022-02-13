class ApplicationController < ActionController::API
  def authenticate
    is_auth = request.headers["Authorization"] && request.headers["Authorization"].match?(/Bearer secret-/)

    unless is_auth
      render json: {
        error: "Not Authorized"
      }, status: 403
    end
  end
end
