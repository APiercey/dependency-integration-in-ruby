require "securerandom"

class OauthsController < ApplicationController
  before_action :set_oauth, only: %i[ show update destroy ]
  before_action :set_oauth_by_secrets, only: %i[ token ]

  # GET /oauths
  def index
    @oauths = Oauth.all

    render json: @oauths
  end

  # GET /oauths/1
  def show
    render json: @oauth
  end

  # POST /oauths
  def create
    @oauth = Oauth.new(oauth_params)

    if @oauth.save
      render json: @oauth, status: :created, location: @oauth
    else
      render json: @oauth.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /oauths/1
  def update
    if @oauth.update(oauth_params)
      render json: @oauth
    else
      render json: @oauth.errors, status: :unprocessable_entity
    end
  end

  # DELETE /oauths/1
  def destroy
    @oauth.destroy
  end

  def token
    if @oauth.present?
      render json: {
        access_token: "secret-#{SecureRandom.hex(30)}"
      }
    else
      render json: {error: "Unauthorized"}, status: 403
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oauth
      @oauth = Oauth.find(params[:id])
    end

    def set_oauth_by_secrets
      @oauth = Oauth.find_by(client_id: params[:client_id], client_secret: params[:client_secret])
    end

    # Only allow a list of trusted parameters through.
    def oauth_params
      params.require(:oauth).permit(:client_id, :client_secret)
    end
end
