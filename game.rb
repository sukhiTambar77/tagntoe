class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]	
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
    @player1 = {:marker => 'X',:positions => [],:type => 'Human1'}
    @player2 = {:marker => 'O',:positions => [],:type => 'Human2'}
    @turn = 1
    @winning_combinations = [[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],[2, 5, 8],[0, 4, 8],[2, 4, 6]]
    @winners = ['123', '456', '789', '147','258', '369', '159', '357']
    @spots = {"1" => [0,0], "2" => [0,1], "3" => [0,2], "4" => [1,0], "5" => [1,1], "6" => [1,2],"7" => [2,0], "8" => [2,1], "9" => [2,2]}
  end

  def start_game
    # start by printing the board
    puts "\n\n \t\t #{@board[0]} \t | \t #{@board[1]} \t | \t #{@board[2]} \n\n \t\t ========+===============+=========\n\n \t\t #{@board[3]} \t | \t #{@board[4]} \t | \t #{@board[5]} \n\n \t\t========+==============+===========\n\n \t\t #{@board[6]} \t| \t #{@board[7]} \t | \t #{@board[8]} \n"
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
     if (@turn <= 10) 
      get_human_spot(@player1)
      puts "\n\n \t\t #{@board[0]} \t | \t #{@board[1]} \t | \t #{@board[2]} \n\n \t\t ========+===============+=========\n\n \t\t #{@board[3]} \t | \t #{@board[4]} \t | \t #{@board[5]} \n\n \t\t========+==============+===========\n\n \t\t #{@board[6]} \t| \t #{@board[7]} \t | \t #{@board[8]} \n"
      if !game_is_over(@board) && !tie(@board)
       get_human_spot(@player2)
       puts "\n\n \t\t #{@board[0]} \t | \t #{@board[1]} \t | \t #{@board[2]} \n\n \t\t ========+===============+=========\n\n \t\t #{@board[3]} \t | \t #{@board[4]} \t | \t #{@board[5]} \n\n \t\t========+==============+===========\n\n \t\t #{@board[6]} \t| \t #{@board[7]} \t | \t #{@board[8]} \n"
      end 
      #if !game_is_over(@board) && !tie(@board)
      #  eval_board
      #end
     else
       puts "\n\n \t\t Game over:: All spots ocuupied Bye!!"
       return 
     end
    end
    puts "\n\n Game Over!! "
  end

  def get_human_spot(player)
    spot = nil
    until spot
     puts "\n\n\t\t Turn #{@turn} :: Enter [1-9]: for Player #{player[:type]} ::"
      spot = gets.chomp.to_i
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = player[:marker]
        player[:positions] << spot
      else
        puts "\n\n\t\tInvalid position Please try again!!\n\n"
        spot = nil
      end
    end
    @turn = @turn + 1
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end


  def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

end

game = Game.new
game.start_game



