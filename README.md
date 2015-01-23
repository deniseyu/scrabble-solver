# Scrabble Solver

This is a side project that helps Scrabble aficionados (or people who are bad at Scrabble) score more points.

## To Use

Clone the repo:

```
git clone git@github.com:deniseyu/scrabble-solver.git
cd scrabble-solver
```

Bundle install the dependencies and rackup.

To test, run 'rspec' from the root directory.

## How It Works

This project wound up being more mathy than I anticipated. When the 'scrabblefy!' grand finale method is invoked, the program goes through the following steps:

1. Intakes a string of letters and builds every possible permutation of every length down to 2, which is the minimum acceptable length of Scrabble words.
2. Eliminates the non-unique anagrams.
3. Checks the unique anagrams against the Scrabble dictionary, which lives in a textfile. Thanks to Ben's help, the search method has been optimized with an indexed alphabetical hash.
4. Calculates the point value of each word using a hash containing letters as keys and Scrabble points as values.
5. Arranges the words from lowest to highest rank, and returns the N- most valuable words.

The scrabblefy! method takes two arguments: a string and a number, where the string is presumably the letters you have on your dock and the number is how many anagrams you want returned. By default, 5 anagrams will be returned.

## To Do

* Build back-end validation to reject strings that are impractically long
* Refactor!!
