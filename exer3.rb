
class Game

  def initialize
    @game = [
      [2, 8, 3],
      [1, 6, 4],
      [7, 0, 5]
    ]
    @solution = [
      [1, 2, 3],
      [8, 0, 4],
      [7, 6, 5]
    ]
    @attempts = 0
    @enter_stop = false 
  end

  def run
    while @game != @solution do
      show_game 
      puts "Attempts: #{@attempts}"
      #h = h1_random
      h = h2_final_pos
      h1_random unless h
      gets if @enter_stop 
      sleep 0.35
    end
    puts "-----------------------------"
    show_game 
    puts "SUCCESS!!"
  end

  def h1_random
    rand = rand 1..4
    move_top if rand == 1
    move_right if rand == 2
    move_left if rand == 3
    move_bot if rand == 4
  end

  def h2_final_pos
    pos = get_pos 0
    begin
      return move_left if @game[pos[1]][pos[0]-1] == @solution[pos[1]][pos[0]] 
      return move_right if @game[pos[1]][pos[0]+1] == @solution[pos[1]][pos[0]] 
      return move_bot if @game[pos[1]+1][pos[0]] == @solution[pos[1]][pos[0]] 
      return move_top if @game[pos[1]-1][pos[0]] == @solution[pos[1]][pos[0]] 
    rescue
      return false
    end
  end

  def get_pos(num)
    @game.each_with_index do |row, index|
      col_index = row.index(num)
      return [col_index, index] if col_index != nil
    end
  end

  def move_right
    pos = get_pos 0
    if pos[0] < 2
      @game[pos[1]][pos[0]] = @game[pos[1]][pos[0]+1]
      @game[pos[1]][pos[0]+1] = 0
      @attempts += 1
      return true
    end
    false
  end
  
  def move_left
    pos = get_pos 0
    if pos[0] > 0
      @game[pos[1]][pos[0]] = @game[pos[1]][pos[0]-1]
      @game[pos[1]][pos[0]-1] = 0
      @attempts += 1
      return true
    end
    false
  end

  def move_top 
    pos = get_pos 0
    if pos[1] > 0
      @game[pos[1]][pos[0]] = @game[pos[1]-1][pos[0]]
      @game[pos[1]-1][pos[0]] = 0
      @attempts += 1
      return true
    end
    false
  end

  def move_bot
    pos = get_pos 0
    if pos[1] < 2
      @game[pos[1]][pos[0]] = @game[pos[1]+1][pos[0]]
      @game[pos[1]+1][pos[0]] = 0
      @attempts += 1
      return true
    end
    false
  end

  def show_game
    puts '_____________'
    @game.each do |row|
      line = row.join(' | ')  
      puts '| ' + line.gsub('0', ' ') + ' |'
    end
    puts '|___________|'
  end
end

Game.new.run
