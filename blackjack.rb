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
  puts "*******************************"
end

def deal_player_hand(deck)
  suite_one = deck.keys.sample 
  suite_two = deck.keys.sample
  card_one= deck[suite_one].sample
  card_two = deck[suite_two].sample
  puts "You have #{card_one} of #{suite_one} and #{card_two} of #{suite_two}"
  return card_one, card_two
end

def deal_dealer_hand(deck)
  suite_one = deck.keys.sample 
  suite_two = deck.keys.sample
  card_one = deck[suite_one].sample
  card_two = deck[suite_two].sample
  puts "DEALER has #{card_one} of #{suite_one} and #{card_two} of #{suite_two}"
  return card_one, card_two
end

def hit(deck)
  suite = deck.keys.sample 
  card = deck[suite].sample
end

def check_points(points)
  if points == 21
    puts "You have #{points}! You Win!"
    game_over = "y"
  elsif points > 21
    puts "You have #{points}, You BUST!"
    game_over = "y"
  elsif points < 21
    puts "You have #{points}"
    game_over = 'n'  
  end
end

def check_dealer_points(points)
  if points > 17
    puts "Dealer stands at #{points}"
    game_over = "y"
  elsif points <= 17
    puts "Dealer has #{points}"
  elsif points > 21 
    puts "Dealer Bust! You Win"
    game_over = "y"
  elsif points == 21
    puts "Dealer BlackJack"
    game_over = "y"
  end
end


clear_screen
puts "Welcome to BlackJack! Press RETURN when you are ready to play."
ready = gets.chomp

player_hand = deal_player_hand(deck)

begin
  design
  puts "You have #{player_hand.inject(:+)} total."
  design
  puts "Hit or Stand?"
  player_choice = gets.chomp.downcase

  if player_choice[0] == "h"
    clear_screen
    p player_hand << hit(deck)
    points = player_hand.inject(:+)
    check_points(points)
  
  elsif player_choice[0] == "s"
    dealer_hand = deal_dealer_hand(deck)
    points = dealer_hand.inject(:+)
    check_dealer_points(points)
  end
end until check_points(points) == "y" || check_dealer_points(points) == "y"

puts "Game Over"

