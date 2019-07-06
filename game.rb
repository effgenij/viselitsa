class Game
  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ''
      abort 'Слова нет. Выход из программы'
    end
    return slovo.upcase.split('')
  end

  def ask_next_letter
    puts "\n Введите следующую букву"

    letter = ''

    while letter == '' do
      letter = STDIN.gets.encode('UTF-8').chomp
    end

    next_step(letter)
  end

  def next_step(bukva)
    bukva.upcase!
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva) ||
      (bukva == "Е" && @letters.include?("Ё")) ||
      (bukva == "Ё" && @letters.include?("Е")) ||
      (bukva == "И" && @letters.include?("Й")) ||
      (bukva == "Й" && @letters.include?("И"))
      @good_letters << bukva

      if bukva == "И"
        @good_letters << "Й"
      end

      if bukva == "Й"
        @good_letters << "И"
      end

      if bukva == "Е"
        @good_letters << "Ё"
      end

      if bukva == "Ё"
        @good_letters << "Е"
      end

      if (@letters - @good_letters).empty?
        @status = 1
      end

    else
      @bad_letters << bukva

      @errors += 1

      if @errors >= 7
        @status = -1
      end
    end
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def status
    @status
  end

  def errors
    @errors
  end
end
