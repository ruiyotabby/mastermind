module Colors

  RED =  "\e[31m\u2b24\e[0m"
  BLUE = "\e[34m\u2b24\e[0m"
  GREEN = "\e[32m\u2b24\e[0m"
  YELLOW = "\e[33m\u2b24\e[0m"
  WHITE = "\e[40m\u2b24\e[0m"
  PINK = "\e[35m\u2b24\e[0m"

  B = "\u25cb"
  W = "\u25cf"

  def bold(word,color='white')
    w = "\e[1m#{word}\e[0m"
    case color.downcase
    when 'white'
      "\e[40m#{w}\e[0m"
    when 'red'
      "\e[31m#{w}\e[0m"
    when 'blue'
      "\e[34m#{w}\e[0m"
    when 'green'
      "\e[32m#{w}\e[0m"
    when 'yellow'
      "\e[33m#{w}\e[0m"
    when 'pink'
      "\e[35m#{w}\e[0m"
    else
      'Wrong Input'
    end
  end

end

class CodeBreaker
  include Colors

  def start
    display
  end

  private

  def display
    print "\nThe codebreaker tries to guess the pattern of the colors, in both order and color, within eight to twelve turns. "
    print "Each guess is made by placing a row of code pegs on the decoding board. Once placed, the "
    print "codemaker provides feedback by placing from zero to four key pegs. A colored or #{bold('BLACK')} "
    print "key peg is placed for each code peg from the guess which is correct in both"
    puts " color and position. A #{bold('WHITE')} key peg indicates the existence of a correct color code peg placed in the wrong position."
    get_turns
    get_code
    check_guess
  end


  def get_turns
    puts "Enter the number of turns you would like to guess the code (The number should be even and greater than eight and less than twelve)"
    @turns = gets
    if @turns.to_i % 2  == 0 && @turns.to_i >= 8 && @turns.to_i <= 12
      puts "#{@turns.chomp} turns it is."
      get_guess(@turns)
    else
      puts 'Please try again'
      get_turns
    end
  end

  def get_guess(turns)
    print "The colors to be chosen from are; #{RED} Red #{BLUE} Blue #{WHITE} White #{PINK} Pink #{GREEN} Green and #{YELLOW} Yellow."
    puts ' Type your guesses, pick the first letter of each color (e.g. "R" or "r" for red color)'
    @guesses = []
    colors = ['r','g','y','w','p','b']

    while @guesses.length < 4
        print "Enter one color guess then press enter: "
        input = gets
        if colors.include?(input.chomp.downcase)
          case input.chomp.downcase
          when 'r'
            @guesses << RED
          when 'g'
            @guesses << GREEN
          when 'y'
            @guesses << YELLOW
          when 'w'
            @guesses << WHITE
          when 'p'
            @guesses << PINK
          when 'b'
            @guesses << BLUE
          end
        else
          puts 'Please try again'
        end
    end
    print 'Is this your choice of colors(enter "y" or "n"): '
    @guesses.each do |guess|
      print "#{guess} "
    end
    confirm = gets.chomp
    unless confirm == 'y'
      get_guess(turns)
    end

  end

  def get_input

  end

end

class Game
  include Colors

  def start
    display
  end

  private

  def display
    print "Welcome to the Mastermind Game. Mastermind or Master Mind is a code-breaking game for two players"
    print "where there are: code pegs  of six different colors which only four will be chosen; and "
    print "key pegs, #{bold('black')} and #{bold('white')}, which are smaller than the code pegs; "
    puts "they will be placed in the small holes on the board. Google for more."
    puts 'Enough with the chit chat, what would you like to be? The "Code Breaker" or "Code Creator"?'
    get_input
  end

  def get_input
    input = gets.split.join.downcase
    if input == 'codebreaker'
      CodeBreaker.new.start
    elsif input == 'codecreator'

    else
      display
    end
  end

end

CodeBreaker.new.start