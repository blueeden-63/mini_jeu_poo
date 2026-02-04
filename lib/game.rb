class Game
  attr_accessor :human_player, :players_left, :enemies_in_sight

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @players_left = 10
    @enemies_in_sight = []
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && @players_left > 0
  end

  def show_players
    @human_player.show_state
    puts "Ennemis restants à éliminer : #{@players_left}"
    puts "Ennemis en vue : #{@enemies_in_sight.length}"
  end

  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "attaquer un joueur en vue :"

    @enemies_in_sight.each_with_index do |enemy, index|
      next if enemy.life_points <= 0

      print "#{index} - "
      enemy.show_state
    end
  end

  def menu_choice(choice)
    if choice == "a"
      @human_player.search_weapon

    elsif choice == "s"
      @human_player.search_health_pack

    elsif choice.match?(/\A\d+\z/)
      index = choice.to_i
      enemy = @enemies_in_sight[index]

      if enemy.nil?
        puts "Choix invalide : aucun ennemi à cet index."
        return
      end

      @human_player.attacks(enemy)
      kill_player(enemy) if enemy.life_points <= 0

    else
      puts "Choix invalide"
    end
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
    @players_left -= 1
  end

  def enemies_attack
    @enemies_in_sight.each do |enemy|
      next if enemy.life_points <= 0
      enemy.attacks(@human_player)
    end
  end

  def end_game
    puts "La partie est finie"

    if @human_player.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end

  def new_players_in_sight
    if @enemies_in_sight.length == @players_left
      puts "Tous les joueurs sont déjà en vue"
      return
    end

    dice = rand(1..6)

    to_add =
      if dice == 1
        0
      elsif dice <= 4
        1
      else
        2
      end

    if to_add == 0
      puts "aucun ennemi n’arrive"
    elsif to_add == 1
      puts "1 ennemi arrive"
    else
      puts "2 ennemis arrivent"
    end

    available_slots = @players_left - @enemies_in_sight.length
    to_add = [to_add, available_slots].min

    to_add.times do
      name = "joueur_#{rand(1000..9999)}"
      @enemies_in_sight << Player.new(name)
    end
  end
end