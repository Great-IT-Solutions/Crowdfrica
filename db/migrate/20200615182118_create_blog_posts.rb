class CreateBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :summary
      t.references :donor, null: false, foreign_key: true
      t.string :slug, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
