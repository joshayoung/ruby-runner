require "httparty"

class ApiRecord
  def fact
    @fact ||= HTTParty.get("https://cat-fact.herokuapp.com/facts")
  end
end
