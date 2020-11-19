require "byebug"
require "pry-byebug"
require "active_record"

val = ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "./database.db"
)
binding.pry
puts "test"