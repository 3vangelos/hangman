defmodule TextClient.Player do

  alias TextClient.{Mover, Prompter, State, Summary}

  def play(%State{tally: %{ game_state: :won, letters: letters }}) do
    end_with_message("You WON!", letters)
  end

  def play(%State{tally: %{ game_state: :lost, letters: letters }}) do
    end_with_message("Sorry, you lost...", letters)
  end

  def play(game = %State{tally: %{ game_state: :good_guess }}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{ game_state: :bad_guess }}) do
    continue_with_message(game, "Sorry, that's not in the word!")
  end

  def play(game = %State{tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "You've already used that letter")
  end

  def play(game = %State{}) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp continue_with_message(game, msg) do
    IO.puts msg
    continue(game)
  end

  defp end_with_message(msg, letters) do
    IO.puts(["\n", msg, "The word was #{Enum.join(letters)}"])
    exit(:normal)
  end

end
