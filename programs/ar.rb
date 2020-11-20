require "byebug"
require "pry-byebug"
require "active_record"

ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "./database.db"
)

def create
  ActiveRecord::Schema.define do
    create_table :test_table, force: true do |t|
      t.string :first
      t.string :last
      t.datetime :year_born
    end
  end
end

create

puts "script ended..."
