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

class HumanPlayer
  attr_accessor :weapon_level, :name, :life_points, :damage
  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_level = 1
  end
  def show_state
    if @life_points <= 0
      puts "Le joueur #{@name} a été tué !"
    else
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
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
    rand(1..6) * @weapon_level
  end
  def search_weapon
    dice = rand(1..6)
    puts "Tu as trouvé une arme de niveau#{dice}"
    if dice > @weapon_level
      @weapon_level = dice
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else 
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end
  def search_health_pack
    health_dice = rand(1..6)
    if health_dice = 1
      puts "Tu n'as rien trouvé..."
    elsif health_dice = (2..5)
      "Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points = @life_points + 50
    else
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
      @life_points = @life_points + 80
    end
  end
end
#binding.pry