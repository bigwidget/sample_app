# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'open-uri'

Affiliation.delete_all
open("#{Rails.root}/db/libertarian_affiliations.txt") do |affiliations|
  affiliations.read.each_line do |affiliation|
    Affiliation.create!(:name => affiliation.chomp)
  end
end
  