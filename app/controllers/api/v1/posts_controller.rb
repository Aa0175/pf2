class Api::V1::PostsController < ApiController
  before_action :set_post, only: [:show, :update, :destroy]

  rescue_from Exception, with: :render_status_500

# ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    posts = Post.all
    render json: posts
  end

  def show
    post_id = params[:id]
    root_node = Node.find_by(post_id: post_id, parent_id: nil)
    todo = root_node.id
    $result = recursive_dfs(todo)
    render json: $result
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, satatus: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update_attributes(post_params)
      head :no_content
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    head :no_content
  end

  private

    def set_post
      @post = Post.find(params[:id])
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
