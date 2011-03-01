class AddScoreToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :score, :integer
    add_index :links, :score
  end

  def self.down
    remove_column :links, :score
  end
end
