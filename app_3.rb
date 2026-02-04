require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !     |"
puts "| Le but du jeu est d'être le dernier survivant |"
puts "------------------------------------------------"
puts
print "Quel est ton prénom ? "
name = gets.chomp

my_game = Game.new(name)

while my_game.is_still_ongoing?
  puts
  puts "------------------ ÉTAT DU JEU ------------------"
  my_game.show_players

  puts
  puts "------------------ NOUVEAUX ENNEMIS --------------"
  my_game.new_players_in_sight

  puts
  puts "------------------ MENU -------------------------"
  my_game.menu
  print "> "
  choice = gets.chomp

  puts
  puts "------------------ ACTION -----------------------"
  my_game.menu_choice(choice)

  puts
  puts "------------------ RIPOSTE ----------------------"
  my_game.enemies_attack
end

puts
puts "------------------ FIN --------------------------"
my_game.end_game