require 'io/console'
require 'colorize'

def clear_screen
  system "clear" or system "cls"
end


def botoes(x, y)
  button_width = 20 # Largura

  # Exibir botão na posição especificada
  puts "\e[#{y};#{x}H" + "Testar Função".center(button_width).colorize(background: :blue)

end

def print_header(screen_width)
  header = "Desafio da DIO 2 - Calculadora de partidas Rankeadas"
  puts "+" + "-" * (screen_width - 2) + "+"
  puts "|#{header.center(screen_width - 2).colorize(background: :blue)}|"
  puts "+" + "-" * (screen_width - 2) + "+"
end

def print_table(heroes)
puts "+" + "-" * 50 + "+"
puts "| #{'Herói'.ljust(20)} | #{'Vitórias'.center(10)} | #{'Derrotas'.center(10)} |"
puts "+" + "-" * 50 + "+"
heroes.each do |hero|
  nome_justificado = hero[:nome].ljust(20)
  vitorias_justificado = hero[:vitorias].to_s.center(10)
  derrotas_justificado = hero[:derrotas].to_s.center(10)
  puts "| #{nome_justificado} | #{vitorias_justificado} | #{derrotas_justificado} |"
end
puts "+" + "-" * 50 + "+"

end

def print_table_right(screen_width)
  table_width = 50  # Largura da tabela
  x_position = screen_width - table_width - 1  # Posição inicial da tabela
  puts "\n"
  puts "\e[3;#{x_position}H+" + "-" * (table_width - 2) + "+"
  puts "\e[4;#{x_position}H| #{'Herói'.ljust(20)} | #{'Vitórias'.center(10)} | #{'Nível'.center(10)} |"
  puts "\e[5;#{x_position}H+" + "-" * (table_width - 2) + "+"
  puts "\e[6;#{x_position}H+" + "-" * (table_width - 2) + "+"
end



def calcular_rankeadas(vitorias, derrotas)
  saldo_vitorias = vitorias - derrotas

  nivel = if vitorias < 10
            "Ferro"
          elsif vitorias.between?(11, 20)
            "Bronze"
          elsif vitorias.between?(21, 50)
            "Prata"
          elsif vitorias.between?(51, 80)
            "Ouro"
          elsif vitorias.between?(81, 90)
            "Diamante"
          elsif vitorias.between?(91, 100)
            "Lendário"
          else
            "Imortal"
          end

  return saldo_vitorias, nivel
end

# Lista de heróis
heroes = [
  { nome: "Batman", vitorias: 15, derrotas: 7 },
  { nome: "Superman", vitorias: 40, derrotas: 20 },
  { nome: "Mulher Maravilha", vitorias: 70, derrotas: 15 },
  { nome: "Flash", vitorias: 25, derrotas: 10 },
  { nome: "Aquaman", vitorias: 5, derrotas: 8 },
  { nome: "Lanterna Verde", vitorias: 90, derrotas: 5 },
  { nome: "Ciborgue", vitorias: 12, derrotas: 12 },
  { nome: "Arqueiro Verde", vitorias: 30, derrotas: 25 },
  { nome: "Shazam", vitorias: 60, derrotas: 20 },
  { nome: "Cyborg Superman", vitorias: 100, derrotas: 0 },
  { nome: "Supergirl", vitorias: 35, derrotas: 15 },
  { nome: "Robin", vitorias: 20, derrotas: 18 },
  { nome: "Aqualad", vitorias: 8, derrotas: 5 },
  { nome: "Donna Troy", vitorias: 50, derrotas: 10 },
  { nome: "Martian Manhunter", vitorias: 85, derrotas: 7 },
  { nome: "Zatanna", vitorias: 30, derrotas: 22 },
  { nome: "Constantine", vitorias: 18, derrotas: 8 },
  { nome: "Hawkman", vitorias: 25, derrotas: 20 },
  { nome: "Hawkgirl", vitorias: 40, derrotas: 25 },
  { nome: "Black Canary", vitorias: 45, derrotas: 15 },
  { nome: "Green Arrow", vitorias: 55, derrotas: 30 },
  { nome: "Wonder Twins", vitorias: 10, derrotas: 5 },
  { nome: "Apache Chief", vitorias: 7, derrotas: 3 },
  { nome: "Elongated Man", vitorias: 15, derrotas: 10 },
  { nome: "Plastic Man", vitorias: 20, derrotas: 12 },
  { nome: "Red Tornado", vitorias: 40, derrotas: 20 },
  { nome: "Huntress", vitorias: 25, derrotas: 15 },
  { nome: "Blue Beetle", vitorias: 35, derrotas: 25 },
  { nome: "Booster Gold", vitorias: 60, derrotas: 30 },
  { nome: "Starfire", vitorias: 75, derrotas: 20 },
  { nome: "Beast Boy", vitorias: 45, derrotas: 25 }
]





clear_screen
# Obtém a largura da tela
screen_width = `tput cols`.to_i

# Imprime o cabeçalho
print_header(screen_width)

# Chamada da função para exibir o botão
botoes(70,4)


# Imprime a tabela de heróis
 print_table(heroes)

 print_table_right(screen_width)

gets
clear_screen