class UsersController < ApplicationController
  include Secured
  before_action :valid_authenticate_user, only: [:show, :current, :update]
  before_action :set_user, only: [:show]
  
  # rescue_from Exception do |e|
  #   render json: {error: e.message}, status: 500
  # end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {code: 422, error: e.message}, status: 422
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {code: 404, error: e.message}, status: 404
  end

  # GET /login
  def login
    # validate
    email = params[:email]
    password = Digest::MD5.hexdigest(params[:password])
    @user = User.where(email: email, password: password)
    if @user.count == 1
      render json: {code: 200, message: 'Login OK', 
                    body: UserSerializer.new(@user).serializable_hash}, status: 200
    else
      render json: {code: 401, message: 'Credenciales del usuario invalidas'}, status: 401
    end
  end

  # GET /users
  def index
    @users = User.all
    render json: {code: 200, body: UserSerializer.new(@users).serializable_hash} , status: :ok
  end

  # GET /users/1
  def show
    render json: {code: 200, body: UserSerializer.new(@user).serializable_hash} , status: :ok
  end

  # POST /users
  def create
    @user = User.new(valid_params_user)
    if @user.save
      render json: {code: 200, body: UserSerializer.new(@user).serializable_hash}, 
                    status: :created, location: @user
    else
      render json: {code: 422, errors: @user.errors} , status: :unprocessable_entity
    end
  end

  # GET /users/current
  def current
    #render json: Current.user, status: 200
    render json: {code: 200, body: UserSerializer.new(Current.user).serializable_hash}, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def valid_params_user
      params.require(:user).permit(:name, :email, :password)
    end

    def valid_params_login_user
      params.require(:user).permit(:email, :password)
    end

end