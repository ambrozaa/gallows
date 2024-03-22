class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status
  attr_accessor :version
  MAX_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []

    @status = :in_progress # :won, :lost
  end

  # Метод проверяет введеное слово

  def get_letters(slovo)
    if slovo == nil || slovo == ''
      abort 'Для игры введите загаданное слово в качестве аргумента при ' \
              'запуске программы'
    else
      slovo = slovo.encode('UTF-8')
    end

    slovo.upcase.split('')
  end

  def status
    return @status
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  # ================================================================== (Эти методы работают внутри класса Game)
  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ''
    while letter == ''
      letter = STDIN.gets.encode('UTF-8').chomp
    end

    next_step(letter)
  end

  def is_good?(letter)
    @letters.include?(letter) ||
      (letter == "Е" && @letters.include?("Ё")) ||
      (letter == "Ё" && @letters.include?("Е")) ||
      (letter == "И" && @letters.include?("Й")) ||
      (letter == "Й" && @letters.include?("И"))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when 'И' then letters << "Й"
    when 'Й' then letters << "И"
    when 'Е' then letters << "Ё"
    when 'Ё' then letters << "Е"
    end
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?(letter)
     @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def next_step(letter)
    letter = letter.upcase

    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)
      @good_letters << letter
      @status = :won if solved?
    else
      add_letter_to(@good_letters, letter)
      @bad_letters << letter
      @errors += 1
      @status = :lost if lost?
    end
  end
end
