require "pry"

deck = {
  hearts: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
  clubs: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
  spades: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
  diamonds: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 11],
}

def clear_screen
  system "clear"
end

def design
  puts " "
  puts "****************************************"
  puts " "
end

def deal_player_hand(deck)
  suit_one = deck.keys.sample 
  suit_two = deck.keys.sample
  card_one= deck[suit_one].sample
  card_two = deck[suit_two].sample
  puts "You were delt #{card_one} of #{suit_one} and #{card_two} of #{suit_two}"
  [card_one, card_two]
end

def deal_dealer_hand(deck)
  suit_one = deck.keys.sample 
  suit_two = deck.keys.sample
  card_one = deck[suit_one].sample
  card_two = deck[suit_two].sample
  puts "DEALER was delt 1 face down card and #{card_two} of #{suit_two}"
  [card_one, card_two]
end

def hit(deck)
  suit = deck.keys.sample 
  card = deck[suit].sample
  puts "DEALER delt the #{card} of #{suit}"
  return card
end

def check_points(points)

end

def display_total(player_total, dealer_total)
  puts "_______________"
  puts "|Player Has: #{player_total} "  
  puts "|Dealer Has: #{dealer_total} " 
  puts "---------------"
end

def player_score()

end

# Start Game 
clear_screen
design
puts "Welcome to BlackJack! Press RETURN when you are ready to play."
ready = gets.chomp


clear_screen
# Deal cards
player_hand = deal_player_hand(deck)
if player_hand.inject(:+) == 21
  puts "You have BlackJack! You Win!" 
end

dealer_hand = deal_dealer_hand(deck)
display_total(player_hand.inject(:+), dealer_hand.inject(:+))

 # Player Hits or Stands
begin
  player_total = player_hand.inject(:+)
  if player_total == 21
    puts "You have BlackJack! You Win!"
    exit
  elsif player_total > 21
    puts "You have #{player_total}, You BUSTED!"
    exit
end
  design
  puts "You have #{player_hand.inject(:+)} total."
  design
  puts "Hit or Stand?"
  player_choice = gets.chomp.downcase
  if player_choice[0] == "h"
    clear_screen
    player_hand << hit(deck)
    player_total = player_hand.inject(:+)
    display_total(player_hand.inject(:+), dealer_hand.inject(:+))
    design   
  else
    player_total = player_hand.inject(:+)
  end
end until player_choice[0] == "s"

# Dealer hits or stand
begin
  clear_screen
  display_total(player_hand.inject(:+), dealer_hand.inject(:+))
  design
  puts "DEALER has #{dealer_hand.inject(:+)} total."  
  design
  
  dealer_total = dealer_hand.inject(:+)
  if dealer_total == 21
    puts "Dealer has BlackJack. You Lose"
    break
  elsif dealer_total > 21
    puts "Dealer Bust! You Win"
    break
  elsif dealer_total > 16
    puts "Dealer stands at #{dealer_total}"
    sleep(3)
    dealer_stands = true
  elsif dealer_total < 17
    dealer_hand << hit(deck)
    sleep(3)
    next
  end 
end until dealer_stands

if dealer_stands
  if dealer_total > player_total
    design
    puts "Dealer has #{dealer_total} and Player has #{player_total}"
    puts "Dealer WON!"
    design
  elsif player_total > dealer_total
    design
    puts "Player has #{player_total}, and Dealer has #{dealer_total}"
    puts "Player WON!"
    design
  else
    puts "Its a tie!"
  end
end
