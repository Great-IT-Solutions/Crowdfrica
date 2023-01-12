class AddDonorProfileImageAndColor < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :image, :string
    add_column :donors, :color, :string, null: false, default: '#ff5103'
  end
end
