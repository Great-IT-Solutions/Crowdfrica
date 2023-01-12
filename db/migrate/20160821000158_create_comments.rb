class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false, default: ''

      t.timestamps
    end
  end
end
