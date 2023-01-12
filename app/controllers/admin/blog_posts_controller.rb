class Admin::BlogPostsController < AdminController
  before_action :find_post, only: %i[edit update destroy]

  def new
    @post = BlogPost.new
  end

  def create
    @post = current_admin_user.blog_posts.build(post_params)
    if @post.save
      redirect_to admin_blog_posts_path, notice: 'Blog post created successfully'
    else
      flash.now[:alert] = 'Could not create blog post'
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to admin_blog_posts_path, notice: 'Blog post updated successfully'
    else
      flash.now[:alert] = 'Could not update blog post'
      render :edit
    end
  end

  def destroy
    @post.destroy
    return unless @post.destroyed?

    redirect_to admin_blog_posts_path, notice: 'Blog post deleted successfully'
  end

  private

  def post_params
    params.require(:blog_post).permit(:title, :body, :summary, :image_url, :author_bio, tags: [])
  end

  def find_post
    @post = BlogPost.friendly.find(params[:id])
  end
end
