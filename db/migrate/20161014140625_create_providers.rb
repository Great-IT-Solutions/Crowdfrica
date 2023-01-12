class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :image
      t.string :location
      t.string :url

      t.timestamps
    end
  end
end
