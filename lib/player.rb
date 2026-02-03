require 'pry'

class Player
  attr_accessor :name, :life_points, :damage
  def initialize(name)
    @name = name
    @life_points = 10
  end
  def show_state
    if @life_points <= 0
      puts "Le joueur #{@name} a été tué !"
    else
    puts "#{@name} a #{@life_points} points de vie"
    end
  end
  def gets_damage(damage)
    @life_points = @life_points - damage
  end
  def attacks(player_id)
    puts "Le joueur #{@name} attaque le joueur #{player_id.name}"
    damage = compute_damage
    puts "Le joueur #{@name} inflige #{damage} points de dommages"
    player_id.gets_damage(damage)
  end
  def compute_damage
    return rand(1..6)
  end
end

#binding.pry