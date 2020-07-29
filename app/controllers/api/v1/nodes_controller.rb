class Api::V1::NodesController < ApiController
  before_action :set_node, only: [:show, :update, :destroy]

  rescue_from Exception, with: :render_status_500

  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    nodes = Node.all
    render json: nodes
  end

  def show
    render json: @node
  end

  def create
    node = Node.new(node_params)
    if node.save
      render json: node, satatus: :created
    else
      render json: { errors: node.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @node.update_attributes(node_params)
      head :no_content
    else
      render json: { errors: @node.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @node.destroy!
    head :no_content
  end

  private

    def set_node
      @node = Node.find(params[:id])
    end

    def node_params
      params.fetch(:node, {}).permit(:post_id, :content, :parent_id)
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end
end
