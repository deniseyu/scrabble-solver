require 'json'

class Scrabbler

  attr_reader :index, :dictionary

  def initialize
    @dictionary = JSON.parse(File.open('./scrabble_dictionary.md').read)
    @index = build_index(@dictionary)
  end

  def scrabblefy!(string, number = 5)
    trimmed_anagrams = trim_repeats(find_all_lengths(string))
    verified_anagrams = trim_nonwords(trimmed_anagrams)
    results = sort_by_value(verified_anagrams)
    number >= results.length ? results : results[-number..-1]
  end

  def anagramize(input, length)
    input.chars.permutation(length).to_a.map(&:join)
  end

  def find_all_lengths(input)
    length = input.length
    arr = []
    while length > 1 do
      arr << anagramize(input, length).flatten
      length -= 1
    end
    arr.flatten
  end

  def trim_repeats(anagrams)
    anagrams.uniq
  end

  def verify(word)
    word = word.upcase
    range = @index[word[0,2]]
    return false unless range
    # dictionary = JSON.parse(File.open('./short_words.rb').read)
    @dictionary[range.first..range.last].include?(word)
  end

  def trim_nonwords(anagrams)
    anagrams.select{|word| verify(word)}
  end

  def letter_value(letter)
    values = {  "A" => 1, "B" => 3, "C" => 3, "D" => 2,
                "E" => 1, "F" => 4, "G" => 2, "H" => 4,
                "I" => 1, "J" => 8, "K" => 5, "L" => 1,
                "M" => 3, "N" => 1, "O" => 1, "P" => 3,
                "Q" => 10, "R" => 1, "S" => 1, "T" => 1,
                "U" => 1, "V" => 4, "W" => 4, "X" => 8,
                "Y" => 4, "Z" => 10 }
    values[letter.upcase]
  end

  def valuate(word)
    word.chars.map{|char| letter_value(char)}.reduce(&:+)
  end

  def sort_by_value(anagrams)
    hash = Hash.new
    anagrams.each{|word| hash["#{word}"] = valuate(word)}
    sorted_pairs = hash.sort_by{|key, value| value}
    sorted_pairs.map{|elem| "#{elem[0]} (#{elem[1]})"}
  end

  def build_index(array)
    hash = Hash.new
    key = ''
    array.each_with_index do |value, index|
      new_key = value[0,2]
      unless new_key == key
        hash[key][1] = index - 1 unless key.empty?
        key = new_key
        hash[key] = [index, index]
      end
    end
    hash[key][1] = array.length - 1 unless array.empty?
    hash
  end




end