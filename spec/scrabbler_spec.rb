require 'scrabbler'
require 'benchmark'

describe Scrabbler do

  it 'returns all possible anagrams of a string' do
    expect(subject.anagramize("ab", 2)).to eq ["ab", "ba"]
  end

  it 'returns as many anagrams as there are permutations' do
    expect(subject.anagramize("abcd", 4).count).to eq 24
  end

  it 'finds anagrams of length 3 and 2 for a word of length 3' do
    expect(subject.find_all_lengths("cat")).to eq ["cat", "cta", "act", "atc", "tca", "tac", "ca", "ct", "ac", "at", "tc", "ta"]
  end

  it 'trims redundant anagrams' do
    anagrams = subject.anagramize("aba", 3)
    expect(subject.trim_repeats(anagrams)).to eq ["aba", "aab", "baa"]
  end

  it 'verifies words against the preloaded English dictionary' do
    expect(subject.verify("horse")).to eq true
    expect(subject.verify("Pikachu")).to eq false
  end

  it 'knows the value of each letter' do
    expect(subject.letter_value("A")).to eq 1
    expect(subject.letter_value("J")).to eq 8
    expect(subject.letter_value("z")).to eq 10
  end

  it 'sums up the value of a word' do
    expect(subject.valuate("Nicole")).to eq 8
  end

  it 'trims non-dictionary words' do
    anagrams = ["cat", "cta", "act", "atc", "tca", "tac", "ca", "ct", "ac", "at", "tc", "ta", "c", "a", "t"]
    expect(subject.trim_nonwords(anagrams)).to eq ["cat", "act", "at", "ta"]
  end

  it 'sorts words by point value' do
    anagrams = ["kangaroo", "cat", "pig", "hare", "jackelope"]
    expect(subject.sort_by_value(anagrams)).to eq ["cat (5)", "pig (6)", "hare (7)", "kangaroo (13)", "jackelope (24)"]
  end

  it 'returns top 5 anagrams by default for a string' do
    expect(subject.scrabblefy!("noise")).to eq ["nies (4)", "noes (4)", "onie (4)", "eosin (5)", "noise (5)"]
  end

  describe 'build index' do

    context 'array of size 1' do

      let(:array) { ["HELLO"] }

      it 'should return an index with 1 entry' do
        expect(subject.build_index(array).count).to eq 1
      end

      it 'uses the first two letters as the key' do
        array = ["BIRD"]
        expect(subject.build_index(array)).to eq "BI" => [0,0]
      end

      it 'returns a value of [0,0]' do
        expect(subject.build_index(array)["HE"]).to eq [0,0]
      end

    end

    context 'array of size 2 with same 2 starting letters' do

      let(:array) {["HELLO", "HELP"]}

      it 'should return an index with 1 entry' do
        expect(subject.build_index(array).count).to eq 1
      end

      it 'returns a value of [0,0]' do
        expect(subject.build_index(array)["HE"]).to eq [0,1]
      end

    end

    context 'array of size 2 with same initial letter only' do

      let(:array) {["HELLO", "HIKE"]}

      it 'should return two indices for two entries' do
        expect(subject.build_index(array).count).to eq 2
      end

      it 'has both keys' do
        hash = subject.build_index array
        ['HE', 'HI'].each do |key|
          expect(hash).to have_key key
        end
      end

      it 'returns the correct indexes' do
        hash = subject.build_index array
        [[0,0], [1,1]].each do |value|
          expect(hash).to have_value value
        end
      end

    end

    describe 'execution times' do

      it 'show me the method execution times' do
        p Benchmark.measure{ subject.scrabblefy!("codejam", 15)}
        p subject.scrabblefy!("codejam", 15)
      end

    end

  end

end
