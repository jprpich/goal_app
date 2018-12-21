class CreateGoal < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :message, null: false
      t.integer :user_id, null: false
      t.boolean :public_goal, null: false, default: true
      t.timestamps
    end
  end
end
