require "dry-initializer"

class Student

  extend Dry::Initializer

  # Define params
  param :username
  param :grade

  # Define hash params:
  option :test_scores, as: :average_scores

  # Optional Params:
  option :name, optional: true
end

student = Student.new("student1", 81, test_scores: [71,61, 81, 91])

# You can rename arguments:
puts student.average_scores

p student

# Initialize with optional name populated:
student_with_name = Student.new("student1", 81, test_scores: [71,61, 81, 91], name: "Joe")
p student_with_name
