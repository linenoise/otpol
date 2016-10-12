class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.text :name
      t.float :latitude
      t.float :longitude
      t.references :user, index: true

      t.timestamps
    end
  end
end
