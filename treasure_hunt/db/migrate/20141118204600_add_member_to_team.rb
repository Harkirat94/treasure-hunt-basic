class AddMemberToTeam < ActiveRecord::Migration
  def change
	add_column :teams, :member_id, :integer
  end
end
