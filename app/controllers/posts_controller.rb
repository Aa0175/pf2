class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    if flash[:r_source] != nil
      @r_source = flash[:r_source]
      flash[:r_source] = @r_source
      @node_id = flash[:node_id]
      flash[:node_id] = @node_id
      @node = Node.find(@node_id)
      @chart  = { @node.content => @node.total }
      for node in @node.root.leaves do
        next if node.id == @node.id
        @chart[node.content] = node.total
      end
      # for node in @node.siblings do
      #   next if node.total == 0
      #   @chart[node.content] = node.total
      # end
      # for node in @node.root.children do
      #   @chart[node.content] = node.total
      # end
    end
  end

  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to  new_user_session_path
    end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        $post_id = @post.id
        flash[:first_time] = true
        format.html { redirect_to new_q_nodes_path($post_id) }
        format.json { render :show, status: :created, location: @post }
      else
        flash[:notice] = 'タイトルを入力してください。'
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
      params.require(:post).permit(:title, :user_id, :img, :remove_img)
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
