

class GamesController < ApplicationController



  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end


  def score
    @word = params[:word]
    @grid = params[:grid]
    @score = run_game(@word, @grid, params[:time].to_datetime, Time.new)
  end

  def api_check(message)
    url = "https://wagon-dictionary.herokuapp.com/"
    json_response = URI.open(url + message).read
    result = JSON.parse(json_response)
    result["found"]
  end

  def run_game(attempt, grid, start_time, end_time)
    message_score = score_message(attempt, grid, start_time, end_time)
    { score: message_score[1], message: message_score[0], time: end_time - start_time }
  end

  def score_message(attempt, grid, start_time, end_time)
    if api_check(attempt)
      if correct_message(attempt.upcase, grid)
        return ["Congratulations! #{attempt} is a valid English word!", attempt.size / (end_time - start_time)]
      else
        return ["Sorry but #{attempt} can't be built out of #{grid}", 0]
      end
    else
      return ["Sorry but #{attempt} does not seem to be a valid English word.", 0]
    end
  end

  def correct_message(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

end
