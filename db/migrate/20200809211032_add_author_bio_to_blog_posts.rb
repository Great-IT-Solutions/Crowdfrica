class AddAuthorBioToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :author_bio, :text
  end
end
