# Mini Game — “They All Want Your OOP” (Ruby)

A small, console-based, Fortnite-inspired combat game built to practice **Object-Oriented Programming (OOP)** in **Ruby**.

You’ll build the project progressively through **three versions**:
- **v1.0**: a basic duel between two players (fully guided)
- **v2.0**: a human-controlled player vs two bots (less guided)
- **v3.0**: a cleaner architecture with a `Game` class + more enemies (mostly directives)

> Disclaimer: visuals are intentionally minimal (terminal only). The fun is in the OOP structure.

---

## Tech Stack

- Ruby
- Bundler
- Pry (for debugging / testing)

---

## Project Structure

Recommended folder architecture:

```
mini_jeu_POO
├── lib
│   ├── player.rb
│   └── game.rb
├── app.rb
├── app_2.rb
├── app_3.rb
├── README.md
├── Gemfile
├── Gemfile.lock
└── Other files (.env, .gitignore, ...)
```

---

## Setup

1. Install dependencies:

```bash
bundle install
```

2. Run a version of the game:

```bash
ruby app.rb     # Version 1.0
ruby app_2.rb   # Version 2.0
ruby app_3.rb   # Version 3.0
```

---

## Version 1.0 — Duel: Player vs Player

### Goal
Create a simple fight between **two `Player` objects** until one dies.

### `Player` class (`lib/player.rb`)

A `Player` has:
- `name` (String)
- `life_points` (Integer), starting at **10**

#### Required methods

- `initialize(name)`
  - sets `@name`
  - sets `@life_points = 10`

- `show_state`
  - prints: `NAME has X life points`

- `gets_damage(damage)`
  - subtracts damage from `@life_points`
  - if `@life_points <= 0`, prints: `Player NAME has been killed!`

- `attacks(other_player)`
  - prints: `NAME attacks OTHER`
  - computes damage using `compute_damage`
  - calls `other_player.gets_damage(damage)`
  - prints: `He inflicts X damage`

- `compute_damage`
  - returns a random integer from **1 to 6**

### `app.rb`
Orchestrates the duel:
- creates two players: `"Josiane"` and `"José"`
- loops until one player’s `life_points` reaches 0
- important fix: **do not let a dead player attack**
  - after the first attack, if the target is dead, `break` out of the loop

---

## Version 2.0 — Human Player + Interactive Fight

### Goal
Create a playable game: **you (HumanPlayer)** vs **2 bots** (Josiane + José), turn by turn.

### `HumanPlayer` class (`lib/player.rb`)
Create a new class **in the same file**, inheriting from `Player`.

Differences vs `Player`:
- starts with **100 life points**
- has a `weapon_level` (Integer), starting at **1**

#### Required changes / methods

- `initialize(name)`
  - `@life_points = 100`
  - `@weapon_level = 1`

- `show_state`
  - prints: `NAME has X life points and a weapon level Y`

- `compute_damage`
  - returns `rand(1..6) * @weapon_level`

- `search_weapon`
  - rolls a die (1..6) => new weapon level
  - if better than current weapon, equip it
  - prints appropriate messages

- `search_health_pack`
  - rolls a die (1..6):
    - `1` => found nothing
    - `2..5` => +50 HP (max 100)
    - `6` => +80 HP (max 100)
  - returns a message (and updates life points)

### `app_2.rb`
Interactive loop:
- welcome banner
- ask user name, create `HumanPlayer`
- create `Player` enemies and store them in an array `enemies`
- while the user is alive AND at least one enemy is alive:
  - show user state
  - show a menu:
    - `a` search weapon
    - `s` search health pack
    - `0` attack Josiane
    - `1` attack José
  - then enemies retaliate (only those still alive), using `enemies.each`

---

## Version 3.0 — Game Class + More Enemies

### Goal
Refactor the logic into a proper `Game` class and scale to multiple enemies.

### `Game` class (`lib/game.rb`)

#### Step A — Move logic into `Game`

A `Game` contains:
- `human_player` (HumanPlayer)
- `enemies` (Array of Player)

On initialization:
```ruby
my_game = Game.new("Wolverine")
```
- creates the human player
- creates **4 enemies** and stores them in the enemies array

Required methods:
- `kill_player(player)` removes a dead enemy from the list
- `is_still_ongoing?` returns true if:
  - human is alive
  - and there are enemies left
- `show_players` displays:
  - human state
  - number of remaining enemies
- `menu` prints the available actions
  - do not show dead enemies
- `menu_choice(choice)` executes the action:
  - weapon search, heal, or attack the selected enemy
  - calls `kill_player` if an enemy dies
- `enemies_attack` makes all living enemies attack the human
- `end` prints final message (“game over” + win/lose)

### `app_3.rb` (the conductor)
- welcome banner + ask name
- creates `my_game = Game.new(name)`
- runs the main loop by calling `my_game` methods
- can contain `gets.chomp` pauses for readability

---

## Extra Feature — Enemies Arrive Gradually

To make fights with **10, 20, 100 enemies** possible, enemies should appear little by little.

In `Game`, add:
- `@players_left` (Integer) initialized to **10**
- `@enemies_in_sight` (Array) starts empty and replaces `@enemies`

Update `is_still_ongoing?`:
- the game continues while:
  - human is alive
  - and the human is **not** the last survivor (i.e., there are still enemies left to eliminate)

Add `new_players_in_sight`:
- if all remaining enemies are already in sight:
  - print: “All players are already in sight”
- roll a die:
  - `1`: no new enemy arrives
  - `2..4`: 1 new enemy appears
  - `5..6`: 2 new enemies appear
- create enemies with random names like:
  - `player_1234`, `player_6938`, etc.
- push them into `@enemies_in_sight`

In `app_3.rb`, call:
- `my_game.new_players_in_sight`
right **before** displaying the menu each turn.

---

## Tips

- Use `binding.pry` in `app.rb` while building v1.0 to test your objects quickly.
- Add separators, blank lines, and `gets.chomp` pauses to make the game more readable.
- Have fun tweaking balance: enemy HP, your HP, heal amounts, weapon scaling, etc.

---

## Learning Objectives

By the end of this project you should be comfortable with:
- classes, instances, attributes, methods
- inheritance and method overriding
- encapsulation of game logic
- arrays of objects + iterating (`each`)
- separating responsibilities (`Game` vs `Player`)
- writing a simple interactive CLI loop
