class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]


  def index
    @post_id = params[:post_id]
    @question = Node.find_by(post_id: @post_id, parent_id: nil)
    if @question.nil?
      last_answer
      redirect_to "/posts/#{@post_id}/#/posts/#{@post_id}"
    else
      @answers = @question.children
    end
    $r_source ="show"
  end


  def show
    node_id = params[:id]
    @question = Node.find_by(parent_id: node_id)
    #次の質問がなかったらtrue
    if @question.nil?
      last_answer
      redirect_to "/posts/#{@node.post_id}/#/posts/#{@node.post_id}"
    else
      @answers = @question.children
    end
    #選択肢追加用
    $r_source ="show"
  end


  def new_q
    @node = Node.new

    if $r_source == "a"
      $node_a = Node.last
    end

    @node_a = $node_a

    if flash[:first_time] == true
      $post_title = Post.find($post_id).title
      @node_a = nil
      @first_time = true
      flash[:first_time] = true
    end
    @post_title = $post_title
  end


  def create_q
    @node = Node.new(node_params)
    @node.post_id = $post_id

    respond_to do |format|
      if @node.save
        $node_a.add_child(@node) unless $node_a.nil?

        if flash[:first_time] == true
          # そのpost内で初回create_q時にparent_idをnilにする
          @node.update(parent_id: nil)
          flash[:first_time] = false
        end
        $r_source = "q"
        format.html { redirect_to new_a_nodes_path }
        format.json { render :show, status: :created, location: @node }
      else
        @post_title = $post_title
        flash[:notice] = '質問を入力してください。'
        format.html { render new_q_nodes_path }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end


  def new_a
    @node = Node.new

    if $r_source == "a"
      @nodes = Node.where(parent_id: $parent_id)
      @post = Post.find($post_id)
    elsif $r_source == "q"
      $node_q = Node.last
      @post = Post.find($post_id)
    elsif $r_source == "show"
      q_id = params[:q_id]
      $post_id = params[:post_id]
      $node_q = Node.find(q_id)
      @post = Post.find($post_id)
      $post_title = @post.title
      if Node.where(parent_id: q_id)
        @nodes = Node.where(parent_id: q_id)
      end
    end

    redirect_to ("/posts/#{$post_id}/#/posts/#{$post_id}") and return if $r_source != "q" && (@nodes.nil? || @nodes.length >= 4)

    @post_title = $post_title
    @node_q = $node_q
  end


  def create_a
    @node = Node.new(node_params)
    @node.post_id = $post_id

    respond_to do |format|
      if @node.save
        $node_q.add_child(@node)
        $parent_id = @node.parent_id

        # if $r_source == "show"
        #   @node.total += 1
        #   @node_total = @node.total
        #   @post = Post.find(@node.post_id)
        #   @post.total += 1
        #   @node.save
        #   @post.save
        # end

        #new_q or new_a or post#showに飛ぶ★現在はnodes#index
        if params[:commit] == "他の選択肢を追加"
          $r_source = "a"
          format.html { redirect_to new_a_nodes_path }
          format.json { render :show, status: :created, location: @node }
        elsif params[:commit] == "他の質問を追加"
          $r_source = "a"
          format.html { redirect_to new_q_nodes_path }
        else
          last_answer if $r_source == "show"
          $r_source = "a"
          format.html { redirect_to ("/posts/#{@node.post_id}/#/posts/#{@node.post_id}") and return }
        end
      else
        @post_title = $post_title
        @node_q = $node_q
        @nodes = Node.where(parent_id: $parent_id)
        if params[:commit] == "他の選択肢を追加"
          format.html { render new_a_nodes_path }
          format.json { render json: @node.errors, status: :unprocessable_entity }
        elsif params[:commit] == "他の質問を追加"
          format.html { render new_a_nodes_path } if @nodes.blank?
          format.html { redirect_to new_q_nodes_path }
        else
          flash[:r_source] = "last answer"
          format.html { redirect_to ("/posts/#{@node_q.post_id}/#/posts/#{@node_q.post_id}") and return }
        end
      end
    end
  end


  # GET /nodes/1/edit
  def edit
  end

  # PATCH/PUT /nodes/1
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def node_params
      params.require(:node).permit(:post_id, :content, :parent_id)
    end

    def last_answer
      @node.total += 1
      flash[:node_id] = @node.id
      @node.save
      @nodes = @node.ancestors
      for node in @nodes do
        node.total += 1
        node.save
      end
      @post = Post.find(@node.post_id)
      @post.total += 1
      @post.save
      flash[:r_source] = "last answer"
    end
end
