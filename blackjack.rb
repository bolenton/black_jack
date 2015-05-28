require "pry"

deck = {
  hearts: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
  clubs: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
  spades: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
  clovers: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
}

def clear_screen
  system "clear"
  puts "****************************************"
end

def design
  puts " "
  puts "****************************************"
  puts " "
end

def deal_player_hand(deck)
  suite_one = deck.keys.sample 
  suite_two = deck.keys.sample
  card_one= deck[suite_one].sample
  card_two = deck[suite_two].sample
  puts "You were delt #{card_one} of #{suite_one} and #{card_two} of #{suite_two}"
  return card_one, card_two
end

def deal_dealer_hand(deck)
  suite_one = deck.keys.sample 
  suite_two = deck.keys.sample
  card_one = deck[suite_one].sample
  card_two = deck[suite_two].sample
  puts "DEALER was delt #{card_one} of #{suite_one} and #{card_two} of #{suite_two}"
  return card_one, card_two
end

def hit(deck)
  suite = deck.keys.sample 
  card = deck[suite].sample
  puts "DEALER delt #{card} of #{suite}"
  return card
end

def check_points(points)
  if points == 21
    puts "You have BlackJack! You Win!"
    exit
  elsif points > 21
    puts "You have #{points}, You BUSTED!"
    exit
  elsif points < 21
    game_over = 'n'  
  end
end

def check_dealer_points(points)
  if points == 21
    puts "Dealer has BlackJack. You Lose"
    puts "Dealer stands at #{points}"
    exit
  elsif points > 21
    puts "Dealer Bust! You Win"
    exit
  elsif points > 16
    puts "Dealer stands at #{points}"
    exit
  elsif points < 17
    puts "Dealer has #{points}"
    exit
  end
end

# Start Game 
clear_screen
design
puts "Welcome to BlackJack! Press RETURN when you are ready to play."
ready = gets.chomp

# Deal cards
player_hand = deal_player_hand(deck)
dealer_hand = deal_dealer_hand(deck)

player_total = 0
dealer_total = 0

begin
  design
  puts "You have #{player_hand.inject(:+)} total."
  design
  puts "Hit or Stand?"
  player_choice = gets.chomp.downcase
  
  # Player Hits or Stands
  if player_choice[0] == "h"
    clear_screen
    p player_hand << hit(deck)
    points = player_hand.inject(:+)
    check_points(points)  
  end
  #player_total += points
  #p player_total 
end until player_choice[0] == "s"

# Dealer hits or stand
begin
  design
  puts "DEALER has #{dealer_hand.inject(:+)} total."  
  design
  points = dealer_hand.inject(:+)
  check_dealer_points(points)
  
end until dealer_choice = "s"

puts "Game Over"

