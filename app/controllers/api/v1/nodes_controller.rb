class Api::V1::NodesController < ApiController
  before_action :set_node, only: [:show, :update, :destroy]

  rescue_from Exception, with: :render_status_500

  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    post_id = params[:post_id]
    question = Node.find_by(post_id: post_id, parent_id: nil)
    answers = question.children
    result = []
    result[0] = question
    i = 1
    for a in answers do
      result[i] = a
      i += 1
    end
    render json: result
  end

  def show
    node_id = params[:id]
    question = Node.find_by(parent_id: node_id)
    answers = question.children
    result = []
    result[0] = question
    i = 1
    for a in answers do
      result[i] = a
      i += 1
    end
    render json: result
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

    def recursive_dfs(todo)
      @node = Node.find_by(id: todo)
      hash = {}
      hash['id'] = @node.id
      hash['title'] = @node.content
      if @node.children.present?
        children_todo = @node.children.ids
        i = 1
        loop do
          return hash if children_todo.empty?
          c = children_todo[0]
          if hash['children']
            r = recursive_dfs(c)
            hash['children'][i] = r
            i += 1
          else
            r = recursive_dfs(c)
            hash['children'] = [r]
          end
          children_todo.shift
        end
      else
        return hash
      end
      return hash
    end
end
