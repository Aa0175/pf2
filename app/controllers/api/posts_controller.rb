class Api::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @nodes = Node.where(post_id: params[:id])
  end
end
