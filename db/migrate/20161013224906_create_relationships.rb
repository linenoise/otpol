class CreateRelationships < ActiveRecord::Migration
  def up
    create_table :relationships do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string  :type

      t.timestamps
    end
    add_index :relationships, :from_user_id
    add_index :relationships, [:from_user_id, :type]
    add_index :relationships, [:to_user_id, :type]
    add_index :relationships, [:from_user_id, :to_user_id]
  end
  def down
    drop_table :relationships
  end
end
