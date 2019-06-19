class ResultPrinter
def initialize
  @status_image = []

  current_path = File.dirname(__FILE__)
  counter = 0

  while counter <= 7
    file_name = current_path + "/image/#{counter}.txt"

    begin
      file = File.new(file_name, "r:UTF-8")
      @status_image << file.read
      file.close
    rescue SystemCallError
      # Если случилась такая ошибка мы продолжаем работать дальше, т.к. без
      # изображения виселицы вполне можно играть.
      @status_image << "\n [ изображение не найдено ] \n"
    end

    counter += 1
  end
end

  def print_status(game)
    cls

    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)

    if game.errors >= 7
      puts 'Вы проиграли :('
    else
      if game.good_letters.uniq.sort == game.letters.uniq.sort
        puts "Поздравляем, вы выиграли!\n\n"
      else
        puts 'У вас осталось попыток: ' + (7 - game.errors).to_s
      end
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    for item in letters do
      if good_letters.include?(item)
        result += item + ' '
      else
        result += '__ '
      end
    end

    return result
  end

  def cls
    system('cls') || system('clear')
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end
end
