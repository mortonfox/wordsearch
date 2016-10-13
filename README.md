# wordsearch - Solve word search puzzles

## Introduction

A word search puzzle is a puzzle where you are given a rectangular grid of
letters and a list of words. You have to find the words in the grid. Words may
be located horizontally, vertically or diagonally.

## Usage

An input file consists of the letter grid, followed by a separator line with 3
dashes, followed by a comma-separated list of words.

See [example.txt](example.txt) for an example.

Running the script on this input file produces the following output:

    $ ruby wordsearch.rb example.txt
    Found word fig starting at cell (1, 3) in direction E
    Found word guava starting at cell (1, 5) in direction S
    Found word peach starting at cell (1, 6) in direction S
    Found word pear starting at cell (1, 9) in direction S
    Found word plum starting at cell (2, 7) in direction S
    Found word mango starting at cell (2, 8) in direction S
    Found word prune starting at cell (3, 1) in direction S
    Found word orange starting at cell (3, 3) in direction S
    Found word lemon starting at cell (3, 4) in direction S
    Found word lime starting at cell (4, 2) in direction S
    Found word apple starting at cell (7, 5) in direction E
    Found word grape starting at cell (8, 6) in direction E
    Found word banana starting at cell (9, 5) in direction E
    Found word cherry starting at cell (10, 5) in direction E
    Unused words: apricot, papaya
    Unused letters: vodwcdyhjbwfgztsyxzyhziooxoeqisat
