class AddTagsToBlogPost < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :tags, :text, array: true
  end
end
