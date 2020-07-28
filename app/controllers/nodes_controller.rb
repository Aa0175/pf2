class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    $post_id = params[:post_id] unless params[:post_id].nil?
    @nodes = Node.where(post_id: $post_id)
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
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
        format.html { redirect_to new_a_nodes_path, notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: @node }
      else
        @post_title = $post_title
        format.html { render new_q_nodes_path }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end


  def new_a
    @node = Node.new

    if $r_source == "a"
      @nodes = Node.where(parent_id: $parent_id)
    elsif $r_source == "q"
      $node_q = Node.last
    end

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

        $r_source = "a"
        #new_q or new_a or post#showに飛ぶ★現在はnodes#index
        if params[:commit] == "他の選択肢を追加"
          format.html { redirect_to new_a_nodes_path, notice: 'Node was successfully created.' }
          format.json { render :show, status: :created, location: @node }
        elsif params[:commit] == "他の質問を追加"
          format.html { redirect_to new_q_nodes_path, notice: 'Node was successfully created.' }
        else
          format.html { redirect_to nodes_path(@node.post_id), notice: 'Node was successfully created.' }
        end
      else
        if params[:commit] == "他の選択肢を追加"
          @post_title = $post_title
          @node_q = $node_q
          @nodes = Node.where(parent_id: $parent_id)
          format.html { render new_a_nodes_path }
          format.json { render json: @node.errors, status: :unprocessable_entity }
        elsif  params[:commit] == "他の質問を追加"
          format.html { redirect_to new_q_nodes_path, notice: 'Node was successfully created.' }
        else
          format.html { redirect_to nodes_path(@node.post_id), notice: 'Node was successfully created.' }
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
end
