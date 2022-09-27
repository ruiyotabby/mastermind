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

CodeBreaker.new.display