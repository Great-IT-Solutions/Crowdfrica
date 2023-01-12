module BlogPostsHelper
  def active_class(path)
    return 'active' if current_page?(path)
  end

  def blog_facebook_url(post)
    "https://www.facebook.com/sharer/sharer.php?u=#{blog_post_url(post.slug)}"
  end

  def blog_twitter_url(post)
    'https://twitter.com/intent/tweet?' \
      "text=#{url_encode("You should see this! #{post.title} on")}&" \
      'via=crowdfrica&' \
      "url=#{blog_post_url(post.slug)}&" \
      'hashtags=startup,healthcare,healthinsurance,Africa'
  end
end
