#!/usr/bin/env ruby

require 'debug'

class TicTacToe
  BOARD = [
    1, 2, 3,
    4, 5, 6,
    7, 8, 9
  ]

  WINNING_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
    [1, 5, 9], [3, 5, 7] # diagonals
  ]

  def initialize
    @game_tick = 0
    @moves = {}
  end

  def play
    show_board
    show_tutorial_text

    while true
      move = ask_for_move

      if square_is_not_on_the_board?(move) || square_is_already_crossed_out?(move)
        puts "That is not a valid move! Try again."
        next
      end

      @moves[move] = player_that_has_to_move

      system "clear"

      show_board

      abort("And the winner is... Player #{player_that_has_to_move}! Congratulations!") if player_won? player_that_has_to_move
      abort("It's a draw!") if no_moves_left?

      @game_tick += 1
    end
  end

  private

  def show_board
    puts <<~BOARD
      The board looks like this:

         -------------------
         |  #{@moves.fetch(1, "1")}  |  #{@moves.fetch(2, "2")}  |  #{@moves.fetch(3, "3")}  |
         -------------------
         |  #{@moves.fetch(4, "4")}  |  #{@moves.fetch(5, "5")}  |  #{@moves.fetch(6, "6")}  |
         -------------------
         |  #{@moves.fetch(7, "7")}  |  #{@moves.fetch(8, "8")}  |  #{@moves.fetch(9, "9")}  |
         -------------------
    BOARD
  end

  def show_tutorial_text
    puts <<~MESSAGE

      Make your move by entering the number of the square!
    MESSAGE
  end

  def ask_for_move
    puts "Player #{player_that_has_to_move}, it's your turn! Please enter the square you want to cross out:"

    gets.chomp.to_i
  end

  def player_that_has_to_move
    @game_tick.even? ? "X" : "O"
  end

  def square_is_not_on_the_board?(move)
    !BOARD.include? move
  end

  def square_is_already_crossed_out?(move)
    @moves.has_key? move
  end

  def no_moves_left?
    @moves.size >= BOARD.size
  end

  def player_won?(player)
    crossed_out_squares = @moves.select { |_, value| value == player }.keys

    WINNING_COMBINATIONS.any? { |winning_combo| (winning_combo - crossed_out_squares).empty? }
  end
end

TicTacToe.new.play