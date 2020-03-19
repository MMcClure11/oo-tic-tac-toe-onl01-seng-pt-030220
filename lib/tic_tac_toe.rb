require 'pry'
class TicTacToe
  
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [6, 4, 2],
    [0, 4, 8]
    ]
    
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(index, current_player = "X")
    @board[index] = current_player
  end
  
  def position_taken?(index) 
    @board[index] == "X" || @board[index] == "O"
  end
  
  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end
  
  def turn
    puts "Please pick a number between 1-9."
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else 
      turn 
    end
  end
  
  def turn_count
    turn = 0
    @board.each do |index|
      if index == "X" || index == "O"
      turn += 1 
      end
    end 
    turn
  end
  
  def current_player
    if turn_count.even? 
      player = "X"
    else
      player = "O"
    end
    player
  end
  
  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
 
      position_1 = @board[win_index_1] 
      position_2 = @board[win_index_2] 
      position_3 = @board[win_index_3] 
 
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination 
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
         return win_combination
         #more readible if set to variable, if all this happens, x wins
      end
    end
    false
  end    
      
  def full?
    @board.all? { |i| i == "X" || i == "O" }
  end
  
  def draw?
     full? && !won? ? true : false
  end
  
  def over?
    draw? || won?
  end
  
  def winner
    if won?
      current_player == "X" ? "O" : "X"
    end
  end
  
end

#rspec spec/01_tic_tac_toe_spec.rb --f-f
#rspec spec/02_play_spec.rb --f-f