class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.all
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
  end

  def new_a
    @node = Node.new
    if $r_source == "a"
      @nodes = Node.where(parent_id: $parent_id)
    end
  end

  def new_q
    @node = Node.new
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create_q
    @node = Node.new(node_params)
    @node.post_id = $post_id

    if $r_source == "a"
      $node_a = Node.last
    end

    respond_to do |format|
      if @node.save
        $node_q.add_child(@node)
        $r_source = "q"

        format.html { redirect_to new_a_nodes_path, notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: @node }
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_a
    @node = Node.new(node_params)
    @node.post_id = $post_id
    #node_q呼び出し
    if $r_source == "q"
      $node_q = Node.last
    end

    respond_to do |format|
      if @node.save
        $node_q.add_child(@node)
        $parent_id = @node.parent_id

        $r_source = "a"
        #new_q or new_a or post#showに飛ぶ
        if params[:commit] == "他の選択肢を追加"
          format.html { redirect_to new_a_nodes_path, notice: 'Node was successfully created.' }
          format.json { render :show, status: :created, location: @node }
        elsif params[:commit] == "他の質問を追加"
          format.html { redirect_to new_q_nodes_path, notice: 'Node was successfully created.' }
          format.json { render :show, status: :created, location: @node }
        else
          format.html { redirect_to nodes_path, notice: 'Node was successfully created.' }
          format.json { render :show, status: :created, location: @node }
        end
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { render :show, status: :ok, location: @node }
      else
        format.html { render :edit }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url, notice: 'Node was successfully destroyed.' }
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
