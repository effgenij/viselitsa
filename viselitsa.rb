require_relative 'game'
require_relative 'result_printer'
require_relative 'word_reader'

printer = ResultPrinter.new

reader = WordReader.new

words_file = File.dirname(__FILE__) + "/data/words.txt"

slovo = reader.read_from_file(words_file)

game = Game.new(slovo)

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
