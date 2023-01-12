class AddCommenterToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :commenter, polymorphic: true, null: false
    remove_reference :comments, :donor, index:true, foreign_key: true
  end
end
