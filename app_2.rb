require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "-" * 49
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-" * 49

puts
puts 
  puts "Quel est ton prénom ?"
  print "> "
  user_name = gets.chomp

user = HumanPlayer.new(user_name)
player1 =  Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

  while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
    puts "------------------ ÉTAT DU JOUEUR ------------------"
      user.show_state
    puts 
    puts"------------------ MENU D'ACTION-------------------------"
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "0 - #{player1.show_state}"
    puts "1 - #{player2.show_state}"
    print "> "

    action = gets.chomp
    if action == "a"
      user.search_weapon
    elsif action == "s"
      user.search_health_pack
    elsif action == "0"
      user.attacks(player1)
    elsif action == "1"
      user.attacks(player2)
    else
      puts "Commande inconnue"
    end

    puts 
    puts "------------------ ATTAQUE ENNEMIE ----------------------"
    enemies.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(user)
      end
    end
  end
    puts "------------------ FIN --------------------------"
    if user.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end



