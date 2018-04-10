defmodule Hangman do

  alias Hangman.Game

  defdelegate new_game(), to: Game
  defdelegate tally(game), to: Game
  defdelegate move(game, guess), to: Game

end
