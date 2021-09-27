system "clear"

VALID_CHOICES = %w(r p sc sp l)

WINNING_CHOICES = { 'sc' => ['p', 'l'],
                    'p' => ['r', 'sp'],
                    'r' => ['sc', 'l'],
                    'sp' => ['sc', 'r'],
                    'l' => ['sp', 'p'] }

GRAND_WINNER = 3

def prompt(message)
  puts("=> #{message}")
end

def display_results(choice, computer_choice)
  if WINNING_CHOICES[choice].include?(computer_choice)
    prompt("You won!")
  elsif WINNING_CHOICES[computer_choice].include?(choice)
    prompt("The computer won!")
  else
    prompt("It's a tie!")
  end
end

def welcome
  prompt("Welcome to Rock, Paper, Scissors, Spock, Lizard!")
  sleep(1)
end

def explain_rules
  prompt("Scissors cuts paper and decapitates lizard")
  prompt("Paper covers rock and disproves Spock.")
  prompt("Rock crushes scissors and crushes lizard.")
  prompt("Spock smashes scissors and vaporizes rock.")
  prompt("And lizard poisons Spock and eats paper.")
  prompt("First to 3 wins is the grand winner!")
  sleep(1)
end

def explain_choice
  prompt("r for Rock, p for Paper, sc for Scissors " \
    "sp for Spock and l for Lizard")
  sleep(1)
end

def get_choice
  prompt("Choose one: #{VALID_CHOICES.join(', ')}")
  gets.chomp.downcase
end

def choice_valid?(choice)
  VALID_CHOICES.include?(choice)
end

def show_not_valid_choice
  prompt("That's not a valid choice.")
end

def output_choice(choice)
  case choice
  when 'r'
    prompt("You chose Rock.")
  when 'p'
    prompt("You chose Paper")
  when "sc"
    prompt("You chose Scissors")
  when 'sp'
    prompt("You chose Spock")
  when 'l'
    prompt("You chose Lizard")
  end
end

def output_computer_choice(computer_choice)
  case computer_choice
  when 'r'
    prompt "The computer chose Rock"
  when 'p'
    prompt "The computer chose Paper"
  when "sc"
    prompt "The computer chose Scissors"
  when 'sp'
    prompt "The computer chose Spock"
  when 'l'
    prompt "The computer chose Lizard"
  end
end

def track_score(score, choice, computer_choice)
  if WINNING_CHOICES[choice].include?(computer_choice)
    score[:player] += 1
  elsif WINNING_CHOICES[computer_choice].include?(choice)
    score[:computer] += 1
  else prompt("The scores remain the same!")
  end
end

def grand_winner(score)
  if score[:computer] < GRAND_WINNER && score[:player] < GRAND_WINNER
    prompt("Play again?")
  elsif score[:player] == GRAND_WINNER
    prompt("You are the grand-winner!")
  elsif score[:computer] == GRAND_WINNER
    prompt("The computer beat you and is the grand-winner!")
  else
    prompt("No grand winner yet!")
  end
end

def play_again?
  prompt("Would you like to play again? y/n?")
  gets.chomp.downcase.include? 'y'
end

def show_score(score)
  prompt("Your score is #{score[:player]} " \
  "and the computer's score is #{score[:computer]}")
end

def game_finished(score)
  score[:player] == GRAND_WINNER || score[:computer] == GRAND_WINNER
end

choice = ''
loop do
  score = {
    player: 0,
    computer: 0
  }
  system "clear"
  welcome
  puts "\n"
  explain_rules
  puts "\n"
  loop do
    loop do
      explain_choice
      choice = get_choice
      break if choice_valid?(choice)
      show_not_valid_choice
    end
    output_choice(choice)
    computer_choice = VALID_CHOICES.sample
    output_computer_choice(computer_choice)
    sleep(1)
    display_results(choice, computer_choice)
    sleep(1)
    track_score(score, choice, computer_choice)
    sleep(1)
    system "clear"
    show_score(score)
    sleep(1)
    puts "\n"
    break if game_finished(score)
  end
  grand_winner(score) 
  break unless play_again?
end

prompt("Thank you for playing. Goodbye")
