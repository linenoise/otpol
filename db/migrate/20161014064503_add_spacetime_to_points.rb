class AddSpacetimeToPoints < ActiveRecord::Migration
  def change
  	add_column :points, :moment, :string
  	add_column :points, :location, :string
  end
end
