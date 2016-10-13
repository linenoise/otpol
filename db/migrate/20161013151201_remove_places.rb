class RemovePlaces < ActiveRecord::Migration
  def up
  	drop_table :places

  	remove_column :points, :happened_at
  	remove_column :points, :place_id

  	remove_column :users, :specialties
  	remove_column :users, :affiliations
  	remove_column :users, :place_id

  	add_column :users, :place, :text
  end

  def down
	  create_table "places", force: :cascade do |t|
	    t.text     "name"
	    t.float    "latitude"
	    t.float    "longitude"
	    t.integer  "user_id"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  add_index "places", ["user_id"], name: "index_places_on_user_id", using: :btree

  	add_column :points, :happened_at, :datetime
  	add_column :points, :place_id, :integer

  	add_column :users, :specialties, :text
  	add_column :users, :affiliations, :text
  	add_column :users, :place_id, :integer

  	remove_column :users, :place
	end
end
