class RemoveAccomplices < ActiveRecord::Migration
  def change
	remove_column :points, :accomplices, :string
  end
end
