require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

current_path = File.dirname(__FILE__)

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

VERSION = "Игра виселица. Версия 4.\n\n"
sleep 1

word_reader = WordReader.new
words_file_name = current_path + "/data/words.txt"
word = word_reader.read_from_file(words_file_name)

game = Game.new(word)
game.version=(VERSION)

printer = ResultPrinter.new(game)

while game.in_progress? do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)