class RenameMomentsToPoints < ActiveRecord::Migration
  def change

  	remove_index "moments", ["place_id"]
  	remove_index "moments", ["user_id"]

  	rename_table "moments", "points"

	add_index "points", ["place_id"], name: "index_points_on_place_id", using: :btree
  	add_index "points", ["user_id"], name: "index_points_on_user_id", using: :btree
  end
end
