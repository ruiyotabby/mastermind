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
    print "\nWelcome to the Mastermind Game. Mastermind or Master Mind is a code-breaking game for two players"
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
      CodeCreator.new.start
    else
      puts "Sorry, didn't get that"
      display
    end
  end

  def get_turns
    @turns = gets
    if @turns.to_i.even? && @turns.to_i >= 8 && @turns.to_i <= 12
      puts "#{@turns.chomp} turns it is."
      @turns
    else
      puts 'Please try again'
      get_turns
    end
  end

end

class CodeBreaker < Game
  include Colors

  def start
    get_codes
    display
    get_guess
  end

  private

  def display
    print "\nThe codebreaker tries to guess the pattern of the colors, in both order and color, within eight to twelve turns. "
    print "Each guess is made by placing a row of code pegs on the decoding board. Once placed, the "
    print "codemaker provides feedback by placing from zero to four key pegs. A colored or #{bold('BLACK')} "
    print "key peg is placed for each code peg from the guess which is correct in both"
    puts " color and position. A #{bold('WHITE')} key peg indicates the existence of a correct color code peg placed in the wrong position."
    puts "Enter the number of turns you would like to guess the code (The number should be even and greater than eight and less than twelve)"
    get_turns
  end

  def get_codes
    @codes = []
    4.times do
      case rand(1..6)
      when 1
        @codes << RED
      when 2
        @codes << GREEN
      when 3
        @codes << YELLOW
      when 4
        @codes << BLUE
      when 5
        @codes << PINK
      when 6
        @codes << WHITE
      end
    end
    @codes
  end

  def check_guess
    @blacks = []
    print "\n\t"
    wrong_guess = []
    wrong_answer = []
    peg_pairs = @guesses.zip(@codes)

    peg_pairs.each do |guess_peg, answer_peg|
      if guess_peg == answer_peg
        print "#{B} "
        @blacks << B
      else
        wrong_guess << guess_peg
        wrong_answer << answer_peg
      end
    end
    wrong_guess.each do |peg|
      if wrong_answer.include?(peg)
        print "#{W} "
        wrong_answer.delete(peg)
      end
    end
    puts ''
  end

  def get_guess
    @blacks = []
    turns = @turns.to_i
    while turns >= 1 && @blacks.length < 4
      print "\nThe colors to be chosen from are; #{RED} Red #{BLUE} Blue #{WHITE} White #{PINK} Pink #{GREEN} Green and #{YELLOW} Yellow."
      print " Remember there are no duplicates or blanks."
      puts "Enter your choice of colors, pick the first letters of each color (e.g. 'RGBW' or 'rgbw' for red, green, blue and white)"
      input = gets.chomp.downcase
      @guesses = []
      colors = ['r','g','y','w','p','b']

      4.times do |i|
        if colors.include?(input[i])
          case input[i]
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
          get_guess
        end
      end
      print 'Is this your choice of colors(enter "y" or "n"): '
      @guesses.each do |guess|
        print "#{guess} "
      end
      confirm = gets.chomp.downcase
      get_guess unless confirm.include?('y') || confirm == ''

      check_guess
      turns -= 1
      puts "\n#{turns} turns remaining"
      puts "\nAlmost got it, try again" if turns.positive? && @blacks.length < 4

    end

    if @blacks.length > 3
      print "Congrats, you won. The code was "
    else
      print 'You have run out of turns.There is always a next time. The code was '
    end
    @codes.each { |code| print "#{code} " }
  end
end

class CodeCreator < Game
  include Colors

  def start
    create_set
    display
  end

  private

  def display
    print "\nThe codemaker chooses a pattern of four code pegs. Players decide in advance whether duplicates and blanks are allowed."
    print " If so, the codemaker may even choose four same-colored code pegs or four blanks. If blanks are not allowed in the code,"
    puts " the codebreaker may not use blanks in their guesses. Blanks and duplicates are not allowed in this case."
    puts "Enter the number of turns you would like the computer to guess the code (The number should be even and greater than eight and less than twelve)"
    get_turns
    get_codes
    show_code
  end

  def show_code
    turns = @turns.to_i
    while turns.positive?
      print 'Your code is '
      @codes.each do |code|
        print "#{code} "
      end
      puts
      puts "The computer\'s guess is #{guess_code}"
    end
  end

  def guess_code
    @rand_set = @set.sample
    p @set.length
    p @rand_set
    input = gets.split.join.downcase
    @impossible = []
    while input
      if input.empty?
        @set.each { |el| @rand_set.split('').each { |num| @impossible << el if el.include?(num) } }
        @impossible.uniq!
        @impossible.each { |el| @set.delete(el) }
        guess_code unless @set.length < 2
      else
        if input.length == 4

          if input == 'bbbb'
            puts "Computer won in #{@turns}"
          else
          end
        end
      end
      guess_code unless @set.length < 2
    end
  end

  def get_codes
    print "The colors to be chosen from are; #{RED} Red #{BLUE} Blue #{WHITE} White #{PINK} Pink #{GREEN} Green and "
    print "#{YELLOW} Yellow.\n Remember there are no duplicates or blanks."
    print "Enter the choice of colors you want the computer to guess, pick the first letters of each color (e.g. 'RGBW'"
    puts " or 'rgbw' for red, green, blue and white)"
    input = gets.chomp.downcase

    if input.length < 4
      puts 'Please try again'
      get_codes
    end

    @codes = []

    4.times do |i|
      case input[i]
      when 'r'
        @codes << RED
      when 'g'
        @codes << GREEN
      when 'y'
        @codes << YELLOW
      when 'w'
        @codes << WHITE
      when 'p'
        @codes << PINK
      when 'b'
        @codes << BLUE
      else
        puts 'Try Again'
        get_codes
      end
    end

    print 'Is this your choice of colors(enter "y" or "n"): '
    @codes.each do |code|
      print "#{code} "
    end
    confirm = gets.chomp.downcase
    get_codes unless confirm.include?('y') || confirm == ''

    @codes
  end

  def create_set
    @set = []
    colors = '123456'.chars
    @set = colors.product(*[colors] * 3).map(&:join)
    @set
  end

end

CodeCreator.new.start