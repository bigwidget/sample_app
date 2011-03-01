class RemoveVoters < ActiveRecord::Migration
  def self.up
    drop_table :voters
  end

  def self.down
    create_table :voters
  end
end
