class AddDigestFrequencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :digest_frequency, :integer
  end
end
