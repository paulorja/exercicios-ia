require 'colorize'

class Game

  def initialize
    @jogadores = { 'a': [], 'b': []}
    @turno = [:a, :b].sample
    @numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @vencedor = nil
    @solucoes = [
      [2, 9, 4],
      [7, 5, 3],
      [6, 1, 8],
      [2, 7, 6],
      [9, 5, 1],
      [4, 3, 8],
      [2, 5, 8],
      [6, 5, 4]
    ]
    start_game
  end

  def start_game
    loop do
      mostrar_jogo
      jogar
    end
  end

  def mostrar_jogo
    system 'clear'
    puts "_________"
    puts "| A | B |"
    [0, 1, 2, 3, 4].each do |i|
      a = @jogadores[:a][i]
      b = @jogadores[:b][i]
      a = "X" if @turno == :a and a.nil?
      b = "X" if @turno == :b and b.nil?
      unless a.nil? and b.nil?
        a = " " if a.nil?
        b = " " if b.nil?
        puts "| #{a} | #{b} |"
      end
      return if a == "X" or b == "X"
    end
  end

  def jogar
    valida_jogo
    puts "Vez do jogador #{@turno.to_s.capitalize}"
    puts "Números válidos: #{(@numeros - @jogadores[:b] - @jogadores[:a]).join(", ")}"
    num = gets.chomp
    if (@jogadores[:a]+@jogadores[:b]).include? num.to_i
      puts "NÃO PODE REPETIR".red
    elsif @numeros.include? num.to_i
      @jogadores[@turno] << num.to_i
      toggle_turno
      return
    else
      puts "NÚMERO INVÁLIDO".red
    end
    jogar
  end

  def valida_jogo
    @solucoes.each do |solucao|
      if @jogadores[:a].include? solucao[0] and @jogadores[:a].include? solucao[1] and @jogadores[:a].include? solucao[2]
        @vencedor = "A"
      end
      if @jogadores[:b].include? solucao[0] and @jogadores[:b].include? solucao[1] and @jogadores[:b].include? solucao[2]
        @vencedor = "B"
      end
    end
    if @vencedor
      puts "********************".yellow
      puts "  JOGADOR #{@vencedor} VENCEU  "
      puts "********************".yellow
      exit
    end
  end

  def toggle_turno
    if @turno == :a 
      @turno = :b
    else
      @turno = :a
    end
  end
end

Game.new
