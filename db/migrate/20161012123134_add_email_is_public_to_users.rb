class AddEmailIsPublicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_is_public, :boolean
  end
end
