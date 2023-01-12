class AddImageUrlToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :image_url, :string, null: false, default: ''
  end
end
