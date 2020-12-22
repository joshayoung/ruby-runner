def test_yield(value)
  puts value
  yield if block_given?
end

def test_yield_with_arguments
  one = 'first'
  two = 'second'
  yield(one, two)
end

test_yield("inside") { puts "testing a block" }
test_yield("no block")

test_yield_with_arguments { |a, b| puts "does #{a} equal #{b}" }