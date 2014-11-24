class CreateGlobalInfos < ActiveRecord::Migration
  def change
    create_table :global_infos do |t|
      t.integer :team_number

      t.timestamps
    end
  end
end
