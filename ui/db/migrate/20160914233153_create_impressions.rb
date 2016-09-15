class CreateImpressions < ActiveRecord::Migration[5.0]
  def change
    create_table :impressions do |t|
      t.references :ad, foreign_key: true
      t.integer :date
      t.integer :hour
      t.integer :counter

      t.timestamps
    end
  end
end
