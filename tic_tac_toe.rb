squares = Hash.new(" ")
square_unused = [1,2,3,4,5,6,7,8,9]
WINNING_LINES = [ [1,2,3],
                  [4,5,6],
                  [7,8,9],
                  [1,4,7],
                  [2,5,8],
                  [3,6,9],
                  [1,5,9],
                  [3,5,7]  ]

def draw_borad(hash)
  system 'clear'
  puts "-------------------"
  3.times.each do |i|
    puts "|  #{hash[1+i*3]}  |  #{hash[2+i*3]}  |  #{hash[3+i*3]}  |"
    puts("------+-----+------") if i < 2
  end
  puts "-------------------"
end

def smarter_choice(squares)
  two_in_a_row = []
  one_in_a_row = []
  WINNING_LINES.each do |line|
    case [squares[line[0]], squares[line[1]], squares[line[2]]].sort
    when [' ', 'X', 'X']
      two_in_a_row  += line.select { |i| squares[i] == ' '}
      break
    when [' ', ' ', 'X']
      one_in_a_row += line.select { |i| squares[i] == ' '}
    end
  end
  if !two_in_a_row.empty?
     two_in_a_row.first
  else
    # I find that there is no duplicate elements in it, so remove the uniq mothod from the chain.
    # Even if there is some duplicate elements, the probability that it will be chosen by user is very high.
     one_in_a_row.sample
  end
end

def let_computer_choice(square_unused,squares)
  computer_choice = smarter_choice(squares)
  squares[computer_choice] = 'O'
  square_unused.delete(computer_choice)
end

def let_user_choice(square_unused,squares)
  begin
    puts "Your choice?#{square_unused}"
    user_choice = gets.chomp.to_i
  end until square_unused.include?(user_choice)
  squares[user_choice] = 'X'
  square_unused.delete(user_choice)
end

def is_winner?(player, squares)
  player_chars = case player
                   when 'user' then 'XXX'
                   when 'computer' then 'OOO'
                   end
  win = false
  WINNING_LINES.each do |line|
    current_line = line.map {|i| squares[i]}
    if current_line.join == player_chars
      win = true
      break
    end
  end
  win
end

once_again = 'y'

while once_again == 'y'
  loop do
    draw_borad(squares)
    let_user_choice(square_unused, squares)
    if is_winner?('user', squares)
      draw_borad(squares)
      puts 'You win!'
      break
    end
    let_computer_choice(square_unused, squares)
    if is_winner?('computer', squares)
      draw_borad(squares)
      puts 'Computer win!'
      break
    end
    break if square_unused.empty?
  end

  unless is_winner?('computer', squares) || is_winner?('user', squares)
    draw_borad(squares)
    puts "It's a tie!"
  end

  puts "Once_again?(y/n)"
  once_again = gets.chomp
end
