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

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def get_letters(slovo)
    if slovo.nil? || slovo == ''
      abort 'Слова нет. Выход из программы'
    end
    slovo.upcase.split('')
  end

  def ask_next_letter
    puts "\n Введите следующую букву"

    letter = ''

    letter = STDIN.gets.encode('UTF-8').chomp while letter == ''

    next_step(letter)
  end

  def is_good?(letter)
    letters.include?(letter) ||
      (letter == "Е" && letters.include?("Ё")) ||
      (letter == "Ё" && letters.include?("Е")) ||
      (letter == "И" && letters.include?("Й")) ||
      (letter == "Й" && letters.include?("И"))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when 'И'
      letters << 'Й'
    when 'Й'
      letters << 'и'
    when 'Е'
      letters << 'Ё'
    when 'Ё'
      letters << 'Е'
    end
  end

  def solved?
    (letters - good_letters).empty?
  end

  def repeated?(letter)
    good_letters.include?(letter) || bad_letters.include?(letter)
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
    letter.upcase!

    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(good_letters, letter)

      @status = :won if solved?
    else
      add_letter_to(bad_letters, letter)

      @errors += 1
      @status = :lost if lost?
    end
  end
end
