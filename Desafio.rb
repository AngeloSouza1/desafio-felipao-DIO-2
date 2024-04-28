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
  mensagem_superior2 = "    Projeto proposto pela  D I O".colorize(:yellow)
  mensagem_superior3 = "    --- Bootcamp Santander ---".colorize( color: :light_red)
  mensagem_superior4 = "   Para testar, aperte uma 'tecla'".colorize(:green)
  mensagem_superior5 = "   Para sair,   aperte a tecla 's'".colorize(:green)
  largura_mensagem = mensagem_superior.length  # Obtém a largura da mensagem
  x_superior = (screen_width - largura_mensagem)-138/ 2  # Calcula a posição horizontal para centralizar a mensagem
  puts "\e[16;#{x_superior}H" + mensagem_superior
  puts "\e[18;#{x_superior}H" + mensagem_superior1
  puts "\e[20;#{x_superior}H" + mensagem_superior2
  puts "\e[22;#{x_superior}H" + mensagem_superior3
  puts "\e[30;#{x_superior}H" + mensagem_superior4
  puts "\e[31;#{x_superior}H" + mensagem_superior5
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

def print_table_right(screen_width, heroes)
  table_width = 80  # Largura da tabela
  x_position = screen_width - table_width - 1  # Posição inicial da tabela

  # Linha superior da tabela
  puts "\e[4;#{x_position}H+" + "-" * (table_width - 2) + "+"

  # Cabeçalho da tabela com fundo azul
  cabecalho = "| #{'Herói'.ljust(17)} | #{'Status de Vitórias'.center(55)} |"
  puts "\e[5;#{x_position}H#{cabecalho.colorize(background: :blue)}"

  # Linha intermediária da tabela
  puts "\e[6;#{x_position}H+" + "-" * (table_width - 2) + "+"

  # Classifica os heróis com base no nível (o segundo elemento do resultado da função calcular_rankeadas)
  heroes_sorted = heroes.sort_by { |hero| calcular_rankeadas(hero[:vitorias], hero[:derrotas])[0] }.reverse

  # Calcular o comprimento máximo de cada coluna
  max_length_nome = heroes_sorted.map { |hero| hero[:nome].length }.max
  max_length_status = heroes_sorted.map { |hero| calcular_rankeadas(hero[:vitorias], hero[:derrotas])[1].length }.max

  # Imprime os dados de cada herói
  heroes_sorted.each_with_index do |hero, index|
    nome = hero[:nome].ljust(max_length_nome)
    resultado = calcular_rankeadas(hero[:vitorias], hero[:derrotas])
    status = resultado[1].ljust(max_length_status)

    # Calcula o comprimento restante da célula da tabela após a impressão do nome e da barra
    remaining_length = 80 - max_length_nome - max_length_status - 7

    # Ajusta o status à direita dentro da célula da tabela
    status_cell = status.ljust(remaining_length)

    # Imprime a linha da tabela
    puts "\e[#{index + 7};#{x_position}H| #{nome} | #{status_cell}    |"
  end

  # Linha inferior da tabela
  puts "\e[#{heroes_sorted.length + 7};#{x_position}H+" + "-" * (table_width - 2) + "+"
end

def calcular_rankeadas(vitorias, derrotas)
  saldo_vitorias = vitorias - derrotas

  nivel = if saldo_vitorias < 10
            "O Herói tem de saldo de  #{saldo_vitorias} está no nível de Ferro".colorize(:light_green)
          elsif saldo_vitorias.between?(11, 20)
            "O Herói tem de saldo de #{saldo_vitorias} está no nível de Bronze".colorize(:light_yellow)
          elsif saldo_vitorias.between?(21, 50)
            "O Herói tem de saldo de #{saldo_vitorias} está no nível de Prata".colorize(:light_blue)
          elsif saldo_vitorias.between?(51, 80)
            "O Herói tem de saldo de #{saldo_vitorias} está no nível de Ouro".colorize(:yellow)
          elsif saldo_vitorias.between?(81, 90)
            "O Herói tem de saldo de #{saldo_vitorias} está no nível de Diamante".colorize(:white)
          elsif saldo_vitorias.between?(91, 100)
            "O Herói tem de saldo de #{saldo_vitorias} está no nível de Lendário".colorize(:cyan)
          else
            "O Herói tem de saldo de #{saldo_vitorias} está no nível de Imortal".colorize(:light_cyan)
          end

  return saldo_vitorias, nivel
end

# Obtém a largura da tela
screen_width = `tput cols`.to_i

loop do
  clear_screen
    # Imprime o cabeçalho
  print_header(screen_width)

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
    { nome: "Chapolin", vitorias: rand(1..150), derrotas: rand(1..30) },
    { nome: "Beast Boy", vitorias: rand(1..150), derrotas: rand(1..30) }
  ]

  # Imprime a tabela de heróis
  print_table(heroes)

  imagem_trofeu(10, 5, 48)

  # Imprime a tabela de heróis à direita
  print_table_right(screen_width, heroes)

  # Imprime a mensagem superior
  mensagem_superior(screen_width)

  # Aguarda a entrada do usuário para atualizar os dados
  input = STDIN.getch
  break if  input == 's'

end
clear_screen