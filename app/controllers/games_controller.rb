require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # @score = params[:guess]
    if included?(params[:guess], params[:letters])
      if english_word?(params[:guess])
        @score = "Congratulations! #{params[:guess]} is a valid English word"
      else
        @score = "Sorry but #{params[:guess]} does not seems to be a valid English word..."
      end
    else
      @score = "Sorry but #{params[:guess]} can't be built out of @letters"
    # @letters
    # @words
    # @included?
    # @english_word?
    end
  end

  private

  def included?(guess, letters)
    guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end

    def english_word?(guess)
        response = open("https://wagon-dictionary.herokuapp.com/#{guess}")
        json = JSON.parse(response.read)
        return json['found']
      end
end
