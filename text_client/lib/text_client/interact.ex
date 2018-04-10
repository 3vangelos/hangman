defmodule TextClient.Interact do

  alias TextClient.State

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> IO.inspect 
  end

  defp setup_state(game) do

    %TextClient.State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

  def play(state) do
    # Interact
    #interact
    play(state)
  end

end
