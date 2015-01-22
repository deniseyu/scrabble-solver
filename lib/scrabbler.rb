require 'json'
require 'set'

class Scrabbler

  def anagramize(input, length)
    input.chars.permutation(length).to_a.map(&:join)
  end

  def trim_repeats(anagrams)
    anagrams.uniq
  end

  def verify(word)
    first_letter = word[0].downcase
    dictionary = JSON.parse(File.open('./'+"#{first_letter}"+'_short_words.rb').read)
    # dictionary = Set.new(words)
    dictionary.include?(word.upcase)
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

  def valuate(word)
    word.chars.map{|char| letter_value(char)}.reduce(&:+)
  end

  def letter_value(letter)
    values = {
      "A" => 1, "B" => 3, "C" => 3, "D" => 2,
      "E" => 1, "F" => 4, "G" => 2, "H" => 4,
      "I" => 1, "J" => 8, "K" => 5, "L" => 1,
      "M" => 3, "N" => 1, "O" => 1, "P" => 3,
      "Q" => 10, "R" => 1, "S" => 1, "T" => 1,
      "U" => 1, "V" => 4, "W" => 4, "X" => 8,
      "Y" => 4, "Z" => 10 }
    values[letter.upcase]
  end

  def trim_nonwords(anagrams)
    anagrams.select{|word| verify(word)}
  end

  def sort_by_value(anagrams)
    hash = Hash.new
    anagrams.each{|word| hash["#{word}"] = valuate(word)}
    sorted_pairs = hash.sort_by{|key, value| value}
    sorted_pairs.map{|elem| "#{elem[0]} (#{elem[1]})"}
  end

  def scrabblefy!(string, number = 5)
    anagrams = find_all_lengths(string)
    trimmed_anagrams = trim_repeats(anagrams)
    verified_anagrams = trim_nonwords(trimmed_anagrams)
    results = sort_by_value(verified_anagrams)
    number >= results.length ? results : results[-number..-1]
  end

end