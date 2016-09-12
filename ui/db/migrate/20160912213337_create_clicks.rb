class CreateClicks < ActiveRecord::Migration[5.0]
  def change
    create_table :clicks do |t|
      t.references :ad, foreign_key: true
      t.string :ip
      t.string :user_agent
      t.string :url
      t.string :time

      t.timestamps
    end
  end
end
