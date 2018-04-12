defmodule TextClient.Mover do

  alias TextClient.State
  def make_move(game = %State{}) do
    tally = Hangman.move(game.game_service, game.guess)
    %State{game | tally: tally}
  end

end
