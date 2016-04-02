class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|

      t.string "title"
      t.text "description"
      t.integer "user_id"
      t.date "start_date"
      t.date "end_date"
      t.integer "progress", :default => 0
      t.boolean "achieved", :default => false

      t.timestamps null: false
    end
  end

  def down
  	drop_table :goals
  end
end
