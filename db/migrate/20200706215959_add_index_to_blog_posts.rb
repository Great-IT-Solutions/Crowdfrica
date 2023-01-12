class AddIndexToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_index :blog_posts, :title, unique: true
  end
end
