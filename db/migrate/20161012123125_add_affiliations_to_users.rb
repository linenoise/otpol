class AddAffiliationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :affiliations, :string
  end
end
