list = [
 {:repo=>"two", :count=>1},
 {:repo=>"two", :count=>2},
 {:repo=>"three", :count=>20}
]

puts list.sort { |a, b| b[:count] <=> a[:count] }
