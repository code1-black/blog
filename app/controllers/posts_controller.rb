class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :check_admin_priv, only: %i[ edit update destroy]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    @categories = Category.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

def myposts
  @posts = current_user.posts
end

def search
  @posts = Post.all 
  if params[:query].present?
    @posts = @posts.joins(:rich_text_body).where("title LIKE ? OR action_text_rich_texts.body LIKE ?", "%#{params[:query]}", "#{params[:query]}")
  end
  if params[:category_id].present?
    @posts = @posts.where(category_id: params[:category_id])
  end

  render :index
end 
  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
   def set_post
      @post = Post.find(params.expect(:id))
    end
    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :body, :category_id, images: [] ])
    end
end
