require "byebug"
require "pry-byebug"
require "active_record"

class DatabaseSchema
  def self.call
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: "./programs/database.db"
    )
    drop_tbl
    create_tbl
    add_to_tbl
  end

  def self.create_tbl
    ActiveRecord::Schema.define do
      create_table :test_tables, force: true do |t|
        t.string :first
        t.string :last
        t.datetime :year_born
      end
    end
  end

  def self.add_to_tbl
    TestTable.find_or_create_by(id: 1)
  end

  def self.drop_tbl
    ActiveRecord::Schema.drop_table(:test_tables, if_exists: true)
  end
end

class TestTable < ActiveRecord::Base; end
DatabaseSchema.call

puts "script ended..."
