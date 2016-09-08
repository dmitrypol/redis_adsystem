class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string :keywords
      t.integer :cpc
      t.integer :budget
      t.string :title
      t.string :body
      t.string :link

      t.timestamps
    end
  end
end
