require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

VERSION = "Игра виселица, версия 4\n\n"

reader = WordReader.new
words_file = File.dirname(__FILE__) + "/data/words.txt"
slovo = reader.read_from_file(words_file)

game = Game.new(slovo)
game.version = VERSION
printer = ResultPrinter.new(game)

while game.in_progress?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
