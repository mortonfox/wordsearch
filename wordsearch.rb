#!/usr/bin/env ruby

require 'set'

class WordPuz
  def initialize
    @puzzle = []
    @words = []
  end

  def process_puz_row line
    @puzzle << line.gsub(/\s/, '').downcase.chars
  end

  def process_words line
    @words += line
      .gsub(/\s/, '')
      .downcase.split(',')
      .reject { |word| word.size < 1 }
  end

  DIRS = {
    NW: [-1, -1], N: [-1, 0], NE: [-1, 1],
    W: [0, -1], E: [0, 1],
    SW: [1, -1], S: [1, 0], SE: [1, 1]
  }

  def sanity_check
    # Allow only rectangular puzzles for now.
    @puzzle.each_with_index { |row, i|
      raise "Row #{i + 1} length of #{row.size} is not #{@row_len}!" if row.size != @row_len
    }

    max_word_size = [@row_len, @row_count].max
    @words.each { |word|
      raise "Length of word #{word} is longer than max possible #{max_word_size} characters!" if word.size > max_word_size
    }
  end

  def check_word word, startpos, dir
    pos = [startpos[0], startpos[1]]
    word.each_char { |c|
      return false if pos[0] < 0 || pos[0] >= @row_count
      return false if pos[1] < 0 || pos[1] >= @row_len
      return false if @puzzle[pos[0]][pos[1]] != c
      pos[0] += dir[0]
      pos[1] += dir[1]
    }
    true
  end

  def mark_word word, startpos, dir
    pos = [startpos[0], startpos[1]]
    word.size.times {
      @used[pos[0]][pos[1]] = true
      pos[0] += dir[0]
      pos[1] += dir[1]
    }
  end

  def solve
    @row_len = @puzzle.first.size
    @row_count = @puzzle.size

    sanity_check

    words_by_first_char = Hash.new { |h, k| h[k] = [] }
    @words.each { |word| words_by_first_char[word[0]] << word }

    unused_words = Set.new(@words)

    @used = ([nil] * @row_count).map { [false] * @row_len }

    0.upto(@row_count - 1) { |i|
      0.upto(@row_len - 1) { |j|
        startpos = [i, j]
        words_by_first_char[@puzzle[i][j]].each { |word|
          DIRS.each { |compass, dir|
            if check_word(word, startpos, dir)
              puts "Found word #{word} starting at cell (#{startpos[0] + 1}, #{startpos[1] + 1}) in direction #{compass}"

              mark_word(word, startpos, dir)
              unused_words.delete(word)
            end
          }
        }
      }
    }

    unused = ''
    0.upto(@row_count - 1) { |i|
      0.upto(@row_len - 1) { |j|
        unused << @puzzle[i][j] unless @used[i][j]
      }
    }

    if unused_words.empty?
      puts "No unused words"
    else
      puts "Unused words: #{unused_words.to_a.join(', ')}"
    end

    puts "Unused letters: #{unused}"
  end
end

def parse_input
  wordpuz = WordPuz.new

  mode = :puzzle
  ARGF.each_line { |line|
    line.strip!
    next if line.empty?

    if line.include? '---'
      mode = :words
      next
    end

    if mode == :puzzle
      wordpuz.process_puz_row line
    else
      wordpuz.process_words line
    end
  }

  wordpuz
end

wordpuz = parse_input
wordpuz.solve

__END__
