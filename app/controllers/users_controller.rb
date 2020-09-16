class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
   @posts = @user.posts
  end

  def search
    @users = User.where('name LIKE ?', "%#{params[:name]}%" )
    render :index
  end

  def attributes
  end

  def save_attributes
    @user = User.new(post_params)

    if @user.save

    else

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :img, :age, :sex, :height, :weight,
                                   :birthplace, :residence, :job, :live_with)
    end
end
