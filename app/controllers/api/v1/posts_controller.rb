class Api::V1::PostsController < ApiController
  before_action :set_employee, only: [:show]

# ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    posts = Post.all
    render json: posts
  end

  def show
    render json: @post
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end
end
