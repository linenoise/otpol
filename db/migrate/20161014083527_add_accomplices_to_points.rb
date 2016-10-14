class AddAccomplicesToPoints < ActiveRecord::Migration
  def change
  	add_column :points, :accomplices, :string
  end
end
