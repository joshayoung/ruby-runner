require "byebug"
require "pry-byebug"
require "active_record"
require "./programs/api_record"

class DatabaseSchema
  def self.call
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: "./programs/database.db"
    )
    drop_tbl
    create_tbl
    insert_to_tb
  end

  def self.create_tbl
    ActiveRecord::Schema.define do
      create_table :facts, force: true do |t|
        t.string :first
        t.string :last
        t.string :fact
        t.datetime :date_requested
      end
    end
  end

  def self.insert_to_tb
    api_record = ::ApiRecord.new
    data = JSON.parse(api_record.fact.body)["all"].first
    tb = Fact.new(
      first: data["user"]["name"]["first"],
      last: data["user"]["name"]["last"],
      fact: data["text"],
      date_requested: DateTime.now.to_s)
    tb.save
  end

  def self.drop_tbl
    ActiveRecord::Schema.drop_table(:test_tables, if_exists: true)
  end
end

class Fact < ActiveRecord::Base; end
DatabaseSchema.call

puts "script ended..."
