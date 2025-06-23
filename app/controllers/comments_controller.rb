class CommentsController < ApplicationController
  before_action :set_post, only: %i[ create ]

  # POST /posts/:post_id/comments
  # POST /posts/:post_id/comments.json
  # Creates a new comment for a post
  # Requires the post_id to be passed in the params
  # and the body of the comment to be included in the request.
  # The user is automatically set to the current_user.
  # Responds with a turbo stream or redirects to the post.
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post }
      end
    else
      flash[:alert] = "Comment could not be saved."
      redirect_to @post
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
  def set_post
    @post = Post.find(params[:post_id])
  end
end
