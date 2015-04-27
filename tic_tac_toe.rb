square_hash = Hash.new(" ")
square_unused = [1,2,3,4,5,6,7,8,9]

def print_square_all(hash)
  puts "-------------------"
  3.times.each do |i|
    puts "|  #{hash[1+i*3]}  |  #{hash[2+i*3]}  |  #{hash[3+i*3]}  |"
    i == 2 ? puts("-------------------") : puts("------+-----+------")
  end
end

def let_computer_choice(square_unused,square_hash)
  computer_choice = square_unused.sample
  square_hash[computer_choice] = 'O'
  square_unused.delete(computer_choice)
end

def let_user_choice(square_unused,square_hash)
  begin
    puts "Your choice?#{square_unused}"
    user_choice = gets.chomp
  end until square_unused.include?(user_choice.to_i)
  square_hash[user_choice.to_i] = 'X'
  square_unused.delete(user_choice.to_i)
end

def is_winner(player, square_hash)
  compute_arr = [ [1,2,3],
                  [4,5,6],
                  [7,8,9],
                  [1,4,7],
                  [2,5,8],
                  [3,6,9],
                  [1,5,9],
                  [3,5,7]  ]
  player == 'user' ? str = 'XXX' : str = 'OOO'
  win = false
  for number_arr in compute_arr
    number_arr.map! {|i| square_hash[i]}
    if number_arr.join == str
      win = true
      break
    end
  end
  win
end

loop do
  print_square_all(square_hash)
  let_user_choice(square_unused, square_hash)
  if is_winner('user', square_hash)
    puts 'You win!'
    break
  end
  let_computer_choice(square_unused, square_hash)
  print_square_all(square_hash)
  if is_winner('computer', square_hash)
    puts 'Computer win!'
    break
  end
  break if square_unused.empty?
end
