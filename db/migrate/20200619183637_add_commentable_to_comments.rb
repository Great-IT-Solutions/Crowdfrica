class AddCommentableToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :commentable, polymorphic: true, null: false
    remove_reference :comments, :project, index:true, foreign_key: true
  end
end
