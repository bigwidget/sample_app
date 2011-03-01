class CreateVoters < ActiveRecord::Migration
  def self.up
    create_table :voters do |t|
      t.integer :voter_id
      t.integer :link_id
      t.integer :direction

      t.timestamps
    end
    
    add_index :voters, :voter_id
    add_index :voters, :link_id
    add_index :voters, [:voter_id, :link_id], :unique => true
  end

  def self.down
    drop_table :voters
  end
end
