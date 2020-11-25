require "active_record"
require "byebug"
require "pry-byebug"

def connect_to_database
  ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "./programs/database.db"
  )
end

def drop_table
  ActiveRecord::Schema.drop_table(:records, if_exists: true)
end

def create_enum_table
  ActiveRecord::Schema.define do
    create_table :records, force: true do |t|
    t.string :code
    t.integer :status
    t.datetime :date_of_record
    end
  end
end

def setup
  drop_table
  create_enum_table
end

class Record < ActiveRecord::Base
  # Enum an Array:
  # enum status: [:active, :disabled, :paused]

  # Enum a Hash:
  enum status: { active: 0, disabled: 1, paused: 2 }
end


def insert_records
  result = Record.new(
    code: SecureRandom.alphanumeric(10),
    status: :active,
    date_of_record: DateTime.now.to_s)
  result.save

  result = Record.new(
    code: SecureRandom.alphanumeric(10),
    status: :paused,
    date_of_record: DateTime.now.to_s)
  result.save
end

connect_to_database
# setup
insert_records

rec = Record.first
puts rec.active?
puts rec.status

recl = Record.last
puts recl.active?
puts recl.status