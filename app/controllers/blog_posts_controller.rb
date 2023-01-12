class BlogPostsController < ApplicationController
  def index
    @recent_posts = BlogPost.with_tag(params[:tag]).limit(4)
    @older_posts = BlogPost.where.not(id: @recent_posts.ids).with_tag(params[:tag])
                           .paginate(page: params[:page], per_page: 5)
  end

  def show
    @post = BlogPost.friendly.find(params[:id])
    @comment = Comment.new
  end
end
