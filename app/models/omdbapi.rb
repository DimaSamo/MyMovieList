class OmdbAPI
  include HTTParty
  BASE_URL="http://www.omdbapi.com/?apikey=4c81e8ec&s="
  def query
    request = HTTParty.get(BASE_URL+@search_input).to_json
    @request_hash = JSON.parse(request)
  end

  def initialize(user_search_input)
    @search_input="#{user_search_input.gsub(" ", "%20")}"
  end
end
