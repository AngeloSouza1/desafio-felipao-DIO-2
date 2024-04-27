require 'io/console'
require 'colorize'

def clear_screen
  system "clear" or system "cls"
end

def imagem_trofeu(x, y, deslocamento_x)
  # Define o texto do troféu
  trofeu = <<-'ASCII'
     ___________  
    '._==_==_=_.' 
    .-\:      /-. 
   | (|:.     |) |
    '-|:.     |-' 
      \::.    /   
       '::. .'    
         ) (      
       _.' '._    
      `"""""""`  
  ASCII

  # Divide o texto do troféu em linhas e adiciona o deslocamento no eixo x
  trofeu.split("\n").each_with_index do |line, index|
    # Imprime cada linha com o deslocamento no eixo x
    puts "\e[#{y + index};#{x + deslocamento_x}H#{line.colorize(:light_cyan)}"
  end
end






def mensagem_superior(screen_width)
  mensagem_superior = " Essa aplicação tem como objetivo,".colorize(:yellow)
  mensagem_superior1= " testar a função".colorize(:yellow) + " CALCULAR_RANKEADAS".colorize(:cyan)
  mensagem_superior2 = " Projeto proposto pela DIO".colorize(:yellow)
  mensagem_superior3 = " --- Bootcamp Santander ---".colorize( color: :light_red)
  mensagem_superior4 = " Para testar, aperte a tecla ENTER".colorize(:green)
  largura_mensagem = mensagem_superior.length  # Obtém a largura da mensagem
  x_superior = (screen_width - largura_mensagem)-138/ 2  # Calcula a posição horizontal para centralizar a mensagem
  puts "\e[20;#{x_superior}H" + mensagem_superior
  puts "\e[22;#{x_superior}H" + mensagem_superior1
  puts "\e[24;#{x_superior}H" + mensagem_superior2
  puts "\e[26;#{x_superior}H" + mensagem_superior3
  puts "\e[30;#{x_superior}H" + mensagem_superior4
end


def print_header(screen_width)
  header = "Desafio da DIO 2 - Calculadora de partidas Rankeadas"
  puts "+" + "-" * (screen_width - 2) + "+"
  puts "|#{header.center(screen_width - 2).colorize(background: :blue)}|"
  puts "+" + "-" * (screen_width - 2) + "+"
end

def print_table(heroes)
puts "+" + "-" * 50 + "+"
puts "| #{'Herói'.ljust(20)} | #{'Vitórias'.center(10)} | #{'Derrotas'.center(10)} |".colorize(background: :blue)
puts "+" + "-" * 50 + "+"
heroes.each do |hero|
  nome_justificado = hero[:nome].ljust(20)
  vitorias_justificado = hero[:vitorias].to_s.center(10).colorize(:cyan)
  derrotas_justificado = hero[:derrotas].to_s.center(10).colorize(:light_red)
  puts "| #{nome_justificado} | #{vitorias_justificado} | #{derrotas_justificado} |"
end
puts "+" + "-" * 50 + "+"

end

def print_table_right(screen_width)
  table_width = 80  # Largura da tabela
  x_position = screen_width - table_width - 1  # Posição inicial da tabela

  # Linha superior da tabela
  puts "\e[4;#{x_position}H+" + "-" * (table_width - 2) + "+"

  # Cabeçalho da tabela com fundo azul
  cabecalho = "| #{'Herói'.ljust(20)} | #{'Status'.center(52)}  |"
  puts "\e[5;#{x_position}H#{cabecalho.colorize(background: :blue)}"

  # Linha intermediária da tabela
  puts "\e[6;#{x_position}H+" + "-" * (table_width - 2) + "+"

  # Linha inferior da tabela
  puts "\e[7;#{x_position}H+" + "-" * (table_width - 2) + "+"
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
  { nome: "Batman", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Superman", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Mulher Maravilha", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Flash", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Aquaman", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Lanterna Verde", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Ciborgue", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Arqueiro Verde", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Shazam", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Cyborg Superman", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Supergirl", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Robin", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Donna Troy", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Martian Manhunter", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Zatanna", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Constantine", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Hawkman", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Hawkgirl", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Black Canary", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Green Arrow", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Wonder Twins", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Apache Chief", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Elongated Man", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Plastic Man", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Red Tornado", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Huntress", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Blue Beetle", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Booster Gold", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Starfire", vitorias: rand(1..150), derrotas: rand(1..30) },
  { nome: "Chapolin", vitorias: 150, derrotas: 0 },
  { nome: "Beast Boy", vitorias: rand(1..150), derrotas: rand(1..30) }
]

clear_screen
# Obtém a largura da tela
screen_width = `tput cols`.to_i

# Imprime o cabeçalho
print_header(screen_width)


# Imprime a tabela de heróis
 print_table(heroes)

imagem_trofeu(10, 5, 48)
 print_table_right(screen_width)


mensagem_superior(screen_width)


gets
clear_screen