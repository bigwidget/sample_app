class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :voter_id
      t.integer :link_id
      t.integer :direction

      t.timestamps
    end
    
    add_index :votes, :voter_id
    add_index :votes, :link_id
    add_index :votes, [:voter_id, :link_id], :unique => true
  end

  def self.down
    drop_table :votes
  end
end
