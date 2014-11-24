class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :team_number
      t.string :ipAddress
      t.string :building
      t.string :floor
      t.string :wing
      t.string :room
      t.time :timeStamp
      t.string :label
      t.integer :ap_id
      t.integer :uid

      t.timestamps
    end
  end
end
