matrix = (1..9).to_a

def display(matrix)
  matrix.each_with_index do |element, index|
    print "#{element}\t"
    print "\n" if (index + 1) % 3 == 0
  end
end

def turn(matrix, count, player_choice)
  if matrix[count - 1].is_a?(Integer)
    matrix[count - 1] = player_choice
    true
  else
    false
  end
end

def check_winner(matrix, player_choice)
  winning_combinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
    [0, 4, 8], [2, 4, 6]             # Diagonals
  ]

  winning_combinations.any? do |combination|
    combination.all? { |index| matrix[index] == player_choice }
  end
end

puts "This is Tic Tac Toe. Here are the indices:\n"
display(matrix)

puts "\nEnter choice for Player 1 (* or 0):"
player1_choice = gets.chomp
until %w[* 0].include?(player1_choice)
  puts 'Invalid choice. Enter * or 0:'
  player1_choice = gets.chomp
end

player2_choice = player1_choice == '*' ? '0' : '*'

winner = nil
current_player = 1

until winner || matrix.none? { |cell| cell.is_a?(Integer) }
  puts "\nPlayer #{current_player}'s turn (#{current_player == 1 ? player1_choice : player2_choice}):"
  choice = gets.to_i

  valid_turn = turn(matrix, choice, current_player == 1 ? player1_choice : player2_choice)
  if valid_turn
    display(matrix)
    if check_winner(matrix, current_player == 1 ? player1_choice : player2_choice)
      winner = "Player #{current_player}"
    else
      current_player = current_player == 1 ? 2 : 1
    end
  else
    puts 'Invalid move! Try again.'
  end
end

if winner
  puts "\n#{winner} wins!"
else
  puts "\nIt's a draw!"
end
