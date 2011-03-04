class RenameParentCommentIdToParentId < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.rename :parent_comment_id, :parent_id
    end
  end

  def self.down
    change_table :votes do |t|
      t.rename :parent_id, :parent_comment_id
    end
  end
end