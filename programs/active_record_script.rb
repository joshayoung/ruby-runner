require "byebug"
require "pry-byebug"
require "active_record"

ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "./programs/database.db"
)

def create
  ActiveRecord::Schema.define do
    create_table :test_tables, force: true do |t|
      t.string :first
      t.string :last
      t.datetime :year_born
    end
  end
end

def doit
  res = TestTable.find_or_create_by(id: 1)
end

def drop
  ActiveRecord::Schema.drop_table(:test_tables, if_exists: true)
end

drop
create
class TestTable < ActiveRecord::Base; end
doit

puts "script ended..."
