require "pry"

deck = {
  hearts: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11, 1], #'J', 'Q', 'K', 'A'],
  clubs: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11, 1], #'J', 'Q', 'K', 'A'],
  spades: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11, 1], #'J', 'Q', 'K', 'A'],
  diamonds: [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11, 1], #'J', 'Q', 'K', 'A'],
}

def clear_screen
  system "clear"
end

def design
  puts " "
  puts "****************************************"
  puts " "
end

def deal_player_hand(deck, name)
  suit_one = deck.keys.sample 
  suit_two = deck.keys.sample
  card_one= deck[suit_one].sample
  card_two = deck[suit_two].sample
  puts "#{name} was delt #{card_one} of #{suit_one} and #{card_two} of #{suit_two}"
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

def display_total(player_total, dealer_total, name)
  puts "_______________"
  puts "|#{name} Has: #{player_total} "  
  puts "|Dealer Has: #{dealer_total} " 
  puts "---------------"
end

def dealer_thinking
  3.times do
    print "..."
    sleep(1.5)  
  end
  puts " "
end

# Start Game 
play_again = ' '


clear_screen
design
puts "Welcome to BlackJack! What is your name?"
name = gets.chomp.capitalize
clear_screen

# Deal cards
player_hand = deal_player_hand(deck, name)
if player_hand.inject(:+) == 21
  puts "BlackJack! #{name} Win!" 
end

dealer_hand = deal_dealer_hand(deck)
display_total(player_hand.inject(:+), dealer_hand.inject(:+), name)

 # Player Hits or Stands
begin
  player_total = player_hand.inject(:+)
  if player_total == 21
    puts "BlackJack! #{name} Win!"
    exit
  elsif player_total > 21
    puts "#{name} has #{player_total}, #{name} BUSTED!"
    exit
end
  design
  puts "#{name} has #{player_hand.inject(:+)} total."
  design
  puts "Hit or Stand?"
  player_choice = gets.chomp.downcase
  if player_choice[0] == "h"
    clear_screen
    player_hand << hit(deck)
    player_total = player_hand.inject(:+)
    display_total(player_hand.inject(:+), dealer_hand.inject(:+), name)
    design   
  else
    player_total = player_hand.inject(:+)
  end
end until player_choice[0] == "s"

# Dealer hits or stand
begin
  clear_screen
  display_total(player_hand.inject(:+), dealer_hand.inject(:+), name)
  design
  puts "DEALER has #{dealer_hand.inject(:+)} total."  
  design
  
  dealer_total = dealer_hand.inject(:+)
  dealer_thinking
  if dealer_total == 21
    puts "Dealer has BlackJack. #{name} Lose"
    break
  elsif dealer_total > 21
    puts "Dealer Bust! #{name} Win"
    break
  elsif dealer_total >= 17
    puts "Dealer stands at #{dealer_total}"
    dealer_stands = true
  elsif dealer_total < 17
    dealer_hand << hit(deck)
    dealer_thinking
    next
  end 
end until dealer_stands

if dealer_stands
  if dealer_total > player_total
    design
    puts "Dealer has #{dealer_total} and #{name} has #{player_total}"
    puts "Dealer WON!"
    design
  elsif player_total > dealer_total
    design
    puts "#{name} has #{player_total}, and Dealer has #{dealer_total}"
    puts "#{name} WON!"
    design
  else
    puts "Its a tie!"
  end
end
