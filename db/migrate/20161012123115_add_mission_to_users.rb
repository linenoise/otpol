class AddMissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mission, :string
  end
end
