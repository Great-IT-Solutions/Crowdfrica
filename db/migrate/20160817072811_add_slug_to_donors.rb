class AddSlugToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :slug, :string
    add_index  :donors, :slug, unique: true
  end
end
