class ExpandUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.text :about
      t.string :location
      t.string :job
      t.string :company
      t.string :college
      t.string :blog
      t.string :facebook
      t.string :twitter
      t.string :linked_in
      t.string :personal_site
      t.boolean :email_private
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :about
      t.remove :location
      t.remove :job
      t.remove :company
      t.remove :college
      t.remove :blog
      t.remove :facebook
      t.remove :twitter
      t.remove :linked_in
      t.remove :personal_site
      t.remove :email_private
    end
  end
end
