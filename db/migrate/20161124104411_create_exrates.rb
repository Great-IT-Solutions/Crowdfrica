class CreateExrates < ActiveRecord::Migration[5.0]
  def change
    create_table :exrates do |t|
      t.numeric :rate, null: false, default: 0.0

      t.timestamps
    end
  end
end
