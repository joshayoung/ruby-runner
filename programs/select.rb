arr = [1, 2, 3]

def my_method(val)
	val == 3 || val == 1
end

val =arr.select do |n| 
	send("my_method", n)
end

puts val