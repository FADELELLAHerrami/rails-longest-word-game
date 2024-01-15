require "json"
require "open-uri"




class GamesController < ApplicationController
  def new
    @alphabets = ['Y','Z','D','Q','Z','Y','Q','I']
  end
  def result
    query = params["SearchName"]
    paramsArray = query.chars
    containAllLetter = new().all? { |char| query.include?(char) }
    # fetch url
    url = "https://wagon-dictionary.herokuapp.com/#{query}"
    user_serialized = URI.open(url).read

    user = JSON.parse(user_serialized)
    raise

    if user["found"] == true && containAllLetter
      @response = "Congratulations! #{query} is a valid English word"
    elsif !user["found"] && containAllLetter
      @response = "Sorry but #{query} does not seem to be a valid English word ..."
    elsif user["found"] && !containAllLetter
      @response = "Sorry but #{query} cant be built out of #{@alphabets.split(', ')}"
    end
  end
end
