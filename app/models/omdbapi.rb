class OmdbAPI
  include HTTParty
  BASE_URL="http://www.omdbapi.com/?apikey=4c81e8ec&"
  def query
    request = HTTParty.get(BASE_URL+"s="+@search_input).to_json
    @request_hash = JSON.parse(request)
  end

  def query_specific(title)
    request = HTTParty.get(BASE_URL+"t="+title).to_json
    @request_hash = JSON.parse(request)
  end

  def initialize(user_search_input)
    @search_input="#{user_search_input.gsub(" ", "%20")}"
  end
end
