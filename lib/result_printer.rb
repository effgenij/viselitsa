class ResultPrinter
  def initialize(game)
    @status_image = []

    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= game.max_errors
      file_name = current_path + "/image/#{counter}.txt"

      begin
        file = File.new(file_name, "r:UTF-8")
        @status_image << file.read
        file.close
      rescue SystemCallError
        @status_image << "\n [ изображение не найдено ] \n"
      end

      counter += 1
    end
  end

  def print_status(game)
    cls
    puts game.version
    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)

    if game.lost?
      puts 'Вы проиграли :('
    elsif game.won?
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось попыток: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    letters.each do |letter|
      result += if good_letters.include?(letter)
                  letter + ' '
                else
                  '__ '
                end
    end

    result
  end

  def cls
    system('cls') || system('clear')
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end
end
