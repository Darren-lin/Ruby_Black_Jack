#!/Users/lind/.rubies/ruby-3.0.4/bin/ruby

# Person class for Player and Dealer
# Includes functions for Person's hand and name
class Person  
    def initialize(name ="Dealer")
        @name = name
        @hand = Array.new
        @hand_value = 0
        @ace_count = 0
    end
    public
    def player_name
        @name
    end
    def player_hand
        @hand.each {|card| puts card.print_card}
    end
    def hand_value
        while @ace_count > 0 && @hand_value > 21
            @hand_value -= 10
            @ace_count -= 1
        end
        return @hand_value
    end
    def add_hand(card)
        @hand.push(card)
        @hand_value += card.value
        @ace_count += 1 if card.value == 11
    end
    def num_cards
        @hand.length
    end
    def toss_hands
        @hand.clear
        @ace_count = 0
        @hand_value = 0
    end
end

# Card class
# Contains functions and attributes of a playing card
class Card
    @@ranks = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    @@suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
    def initialize(rank, suit)
        @rank = rank
        @suit = suit
    end
    public
    def value
        if @rank == 1
            return 11
        end
        return @rank >= 10 ? 10 : @rank
    end
    def print_card
        return  "#{@@ranks[@rank - 1]} of #{@@suits[@suit - 1]}"
    end
end

# Deck class
# Contains functions and attributes of a 52 card playing deck
class Deck
    @@ranks = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    @@suits = [1, 2, 3, 4]
    @@deck = Array.new
    def initialize
        @@ranks.each {|rank| @@suits.each {|suit| @@deck.push(Card.new(rank, suit))}}
        @@deck.shuffle!
    end
    public
    def deal
        @@deck.pop
    end
    def print_deck
        @@deck.each {|card| puts card.print_card}
    end
end

# Begins BLack Jack
print "What is your name? "
player = Person.new(gets.chomp)
dealer = Person.new
deck = Deck.new
puts "\n"
while true
    2.times do
        player.add_hand(deck.deal)
        dealer.add_hand(deck.deal)
    end
    puts player.player_name + ": " + player.hand_value.to_s
    player.player_hand   
    puts "\n"
    puts dealer.player_name + ": " + dealer.hand_value.to_s
    dealer.player_hand 
    print "Would you like to hit or stand? "
    player_move = gets.chomp
    while player_move != "stand" && player_move != "hit"
        puts "Invalid input. Would you like to hit or stand? "
        player_move = gets.chomp
    end
    while player_move != "stand"
        puts "\n"
        player.add_hand(deck.deal)
        puts player.player_name + ": " + player.hand_value.to_s
        player.player_hand
        break if player.hand_value > 21
        print "Would you like to hit or stand? "
        player_move = gets.chomp
        while player_move != "stand" && player_move != "hit"
            puts "Invalid input. Would you like to hit or stand? "
            player_move = gets.chomp
        end
        puts "\n"
    end
    puts "\n"
    if player.hand_value > 21
        puts "\n"
        puts "Player busts with " + player.hand_value.to_s
        puts "Dealer wins with " + dealer.hand_value.to_s
        break
    end

    while dealer.hand_value < 17
        dealer.add_hand(deck.deal)
        puts dealer.player_name + ": " + dealer.hand_value.to_s
        dealer.player_hand
        break if dealer.hand_value > 21
    end
    if dealer.hand_value > 21
        puts "\n"
        puts "Dealer busts with " + dealer.hand_value.to_s
        puts "Player wins with " + player.hand_value.to_s
        break
    end

    if player.hand_value > dealer.hand_value
        puts "\n"
        puts "Player wins with " + player.hand_value.to_s
    elsif player.hand_value < dealer.hand_value
        puts "\n"
        puts "Dealer wins with " + dealer.hand_value.to_s
    elsif player.num_cards == dealer.num_cards
        puts "Draw!"
    else
        puts "\n"
        puts player.num_cards > dealer.num_cards ? "Player wins with " + player.hand_value.to_s : "Dealer wins with " + dealer.hand_value.to_s
    end
    break
end