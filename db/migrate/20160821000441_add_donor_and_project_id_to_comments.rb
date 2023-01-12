class AddDonorAndProjectIdToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :donor,   foreign_key: true
    add_reference :comments, :project, foreign_key: true
  end
end
