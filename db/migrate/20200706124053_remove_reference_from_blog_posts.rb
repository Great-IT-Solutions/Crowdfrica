class RemoveReferenceFromBlogPosts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :blog_posts, :donor, null: false, foreign_key: true
    add_reference :blog_posts, :author, null: false, foreign_key: {to_table: 'admin_users'}
  end
end
