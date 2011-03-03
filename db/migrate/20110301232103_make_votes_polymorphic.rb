class MakeVotesPolymorphic < ActiveRecord::Migration
  def self.up
    change_table :votes do |t|
      t.rename :link_id, :votable_id
      t.string :votable_type
    end
  end

  def self.down
    change_table :votes do |t|
      t.rename :votable_id, :link_id
      t.remove :votable_type
    end
  end
end
