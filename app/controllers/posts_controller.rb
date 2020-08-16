class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # post_id = params[:id]
    # @node = Node.find_by(id: post_id, parent_id: nil)
    # # todo(最初)[0] = root_node.id
    # todo = [@node.id]
    # $test_result = []
    #
    # recursive_dfs(todo)
  end

  # GET /posts/new
  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to  new_user_session_path
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        $post_id = @post.id
        flash[:first_time] = true
        format.html { redirect_to new_q_nodes_path($post_id), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '投稿を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :user_id)
    end

    def recursive_dfs(todo)
      @node = Node.find_by(id: todo)
      $test_result.push(@node.content)
      if @node.children.present?
        children_todo = @node.children.ids
      else
        return
      end

      loop do
        return if children_todo.empty?
        c = children_todo[0]
        recursive_dfs(c)
        children_todo.shift
      end
    end
end
