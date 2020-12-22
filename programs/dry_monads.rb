require "dry/monads"

include Dry::Monads[:result, :do]

class RunSomething
  def call(val)
    yield greater_than(val)
    yield divided_evenly?(val)

    save_value(val)
  rescue StandardError => e
    Failure("Something failed along the way.")
  end

  def save_value(a)
    return "Saving Value: #{a}"
  rescue StandardError => e
    Failure("Something failed along the way.")
  end

  def divided_evenly?(a)
    return Success("#{a} is greater than 10") if a % 2 == 0

    Failure("#{a} cannot be divided evenly")
  end

  def greater_than(a)
    return Success("#{a} is greater than 10") if (a > 10)

    Failure("#{a} was not greater than 10")
  end
end

r = RunSomething.new

# Everything should work:
# puts r.call(20)

# The 'divided_evenly?' should fail and cause 'save_value' not to be executed:
puts r.call(21)
