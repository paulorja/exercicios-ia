@torres = [
  ['A', 'B', 'C', 'D'],
  []
]

def mostrar_torres
  system('clear')
  @torres.each_with_index do |torre, index|
    puts "T#{index+1}: #{torre.join ' - '}"
  end

  puts 'De: '
  de = gets.to_i
  puts 'Para: '
  para = gets.to_i

  if @torres[de-1].size > 0
    @torres[para-1] << @torres[de-1].last
    @torres[de-1].delete_at(@torres[de-1].size-1)
  end

  @torres.delete([])
  if @torres.last.size > 0
    @torres << []
  end

  mostrar_torres
end

mostrar_torres
