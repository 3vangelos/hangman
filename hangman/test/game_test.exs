defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert game.letters == Enum.map(game.letters, &(String.downcase(&1)))
  end

  test "state isn't changed for :won and :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.move(game, "x")
    end
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(moves, game, fn ({guess, state}, new_game) ->
      { new_game, _ } = Game.move(new_game, guess)
      assert new_game.game_state == state
      new_game
    end)
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.move(game, "d")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "after seven bad guesses the game is lost" do
    moves = [
      {"a", :bad_guess},
      {"b", :bad_guess},
      {"c", :bad_guess},
      {"d", :bad_guess},
      {"e", :bad_guess},
      {"f", :bad_guess},
      {"g", :lost}
    ]

    game = Game.new_game("w")

    Enum.reduce(moves, game, fn ({guess, state}, new_game) ->
      { new_game, _ } = Game.move(new_game, guess)
      assert new_game.game_state == state
      new_game
    end)
  end

end
