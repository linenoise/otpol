class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.references :user, index: true
      t.text :description
      t.date :happened_at
      t.references :place, index: true

      t.timestamps
    end
  end
end
