class GamesController < ApplicationController
  require 'open-uri'

  def new
    shuffled_alphabet = ('a'..'z').to_a.shuffle
    @letters = shuffled_alphabet[0..9]
  end

  def score
    guess = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    @user_word = JSON.parse(URI.open(url).read)
    test_word = params[:word].chars
    arr = []
    test_word.each do |letter|
      arr << (params[:letters].include? letter)
    end
    if arr.include? false
      @comment = "The word #{params[:word]} is not included on the list..😥"
    elsif @user_word['found'] == false
      @comment = "I am sorry but #{params[:word]} is not an English word...😂"
    else
      @comment = "The word #{params[:word]} is valid and English, congratz!😁"
    end
  end
end
