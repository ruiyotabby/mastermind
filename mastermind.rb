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
    get_codes
    display
    get_turns
  end

  private

  def display
    print "\nThe codebreaker tries to guess the pattern of the colors, in both order and color, within eight to twelve turns. "
    print "Each guess is made by placing a row of code pegs on the decoding board. Once placed, the "
    print "codemaker provides feedback by placing from zero to four key pegs. A colored or #{bold('BLACK')} "
    print "key peg is placed for each code peg from the guess which is correct in both"
    puts " color and position. A #{bold('WHITE')} key peg indicates the existence of a correct color code peg placed in the wrong position."
  end

  def get_codes
    @codes = []
    for i in (1..4) do
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
    if @codes.uniq.length < 4
      get_codes
    end
  end

  def check_guess
    @blacks = []
    arr1 = {}
    @codes.each { |a| arr1.store(a,'') }
    arr2 = Hash.new
    @guesses.each { |a| arr2.store(a,'') }
    print "\n\t"
    arr1.each_with_index do |(key1,val1),indx1|
      unless arr1[val1] == true || arr2[val1] == true
        if arr1.keys.index(key1) == arr2.keys.index(key1)
          print "#{B} "
          arr1[key1] = true
          arr2[key1] = true
          @blacks << B
        elsif arr1[key1] == arr2[key1]
          print "#{W} "
          arr1[key1] = true
          arr2[key1] = true
        end
      end

    end
    puts ''
  end

  def get_turns
    puts "Enter the number of turns you would like to guess the code (The number should be even and greater than eight and less than twelve)"
    @turns = gets
    if @turns.to_i % 2  == 0 && @turns.to_i >= 8 && @turns.to_i <= 12
      puts "#{@turns.chomp} turns it is."
      get_guess(@turns.to_i)
    else
      puts 'Please try again'
      get_turns
    end
  end

  def get_guess(turns)
    @blacks = []
    while turns >= 1 && @blacks.length < 4
      print "\nThe colors to be chosen from are; #{RED} Red #{BLUE} Blue #{WHITE} White #{PINK} Pink #{GREEN} Green and #{YELLOW} Yellow."
      print " Remember there are no duplicates or blanks."
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
      confirm = gets.chomp.downcase
      unless confirm == 'y' || confirm == ''
        get_guess(turns)
      end
      check_guess
      turns -= 1
      if turns > 0 && @blacks.length < 4
        puts "\nAlmost got it, try again"
      end
    end

    if @blacks.length > 3
      print "Congrats, you won. The code was "
      @codes.each { |code| print "#{code} " }
    else
      print 'You have run out of turns.There is always a next time. The code was '
      @codes.each { |code| print "#{code} " }
    end

  end

end

class CodeCreator

  def start
    display
  end

  private

  def display
    print "The codemaker chooses a pattern of four code pegs. Players decide in advance whether duplicates and blanks are allowed."
    print " If so, the codemaker may even choose four same-colored code pegs or four blanks. If blanks are not allowed in the code,"
    puts " the codebreaker may not use blanks in their guesses. Blanks and duplicates are not allowed in this case."
    get_set
  end

  def get_set
    @set = []
    for i in (1..6) do
      for j in (1..6) do
        for k in (1..6) do
          for l in (1..6) do
            a = i.to_s + j.to_s + k.to_s + l.to_s
            @set << a
          end
        end
      end
    end
    puts @set
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

end

CodeCreator.new.start