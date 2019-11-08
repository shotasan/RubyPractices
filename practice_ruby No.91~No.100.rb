# No.91
# Description:
# Given an array of words and a target compound word, your objective is to find the two words which combine into the target word, returning both words in the order they appear in the array, and their respective indices in the order they combine to form the target word. Words in the array you are given may repeat, but there will only be one unique pair that makes the target compound word. If there is no match found, return null/nil/None.

# Note: Some arrays will be very long and may include duplicates, so keep an eye on efficiency.

# Examples:

# fn(['super','bow','bowl','tar','get','book','let'], "superbowl")      =>   ['super','bowl',   [0,2]]
# fn(['bow','crystal','organic','ally','rain','line'], "crystalline")   =>   ['crystal','line', [1,5]]
# fn(['bow','crystal','organic','ally','rain','line'], "rainbow")       =>   ['bow','rain',     [4,0]]
# fn(['bow','crystal','organic','ally','rain','line'], "organically")   =>   ['organic','ally', [2,3]]
# fn(['top','main','tree','ally','fin','line'], "mainline")             =>   ['main','line',    [1,5]]
# fn(['top','main','tree','ally','fin','line'], "treetop")              =>   ['top','tree',     [2,0]]

# My_answer(false)
def compound_match(fragments, target)
  match_set = fragments.map.with_index{|word, idx| [target.split(word), idx]}.select{|item| item[0].include?("")}
  match_set = match_set.select{ |item| fragments.index(item.first&.last) != nil}
  index1 = match_set.first&.last
  index2 = fragments.index(match_set&.first&.first&.last) || nil
  return nil if index2.nil?

  if fragments[index1] + fragments[index2] == target
    if index1 < index2
      return [fragments[index1], fragments[index2], [index1, index2]]
    else
      return [fragments[index2], fragments[index1], [index1, index2]]
    end
  else
    if index1 < index2
      return [fragments[index1], fragments[index2], [index2, index1]]
    else
      return [fragments[index2], fragments[index1], [index2, index1]]
    end
  end
end

# Best_answer
def compound_match(fragments, target)
  # fragmentsの重複なしの全組み合わせを取得し、reverseを使用して両パターンを検討
  # targetと一致する組み合わせを取得する
  res = fragments.uniq.combination(2).select{ |i| [i.join,i.reverse.join].include?(target) }.flatten
  # 一致する組み合わせがなければnilを返す
  return nil if res.empty?
  # 各単語のインデックスを取得する
  l = res.map{|i| fragments.index(i)}
  m = res.join == target ? l : l.reverse
  res += [m]
end


# No.92
# Description:
# In this example you have to validate if a user input string is alphanumeric.
# The given string is not nil/null/NULL/None, so you don't have to check that.
# The string has the following conditions to be alphanumeric:
# At least one character ("" is not valid)
# Allowed characters are uppercase / lowercase latin letters and digits from 0 to 9
# No whitespaces / underscore

# My_answer
def alphanumeric?(string)
  string.match /\A[a-zA-Z\d]+\z/
end

# Best_answer
def alphanumeric?(string)
  string =~ /\A[A-z\d]+\z/
end


# No.93
# Description:
# In this excercise, we will implement the "merge" function from MergeSort.
# MergeSort is often taught in Computer Science as the canonical example of the "Divide and Conquer" algorithm.
# The strategy of MergeSort is both simple and profound,
# leveraging two simple-to-prove mathematical facts
# (1. That every list of 1 element is "sorted" ... and 2. It is much easier to combine two already-sorted lists into 1 sorted list than it is to sort a big list all at once) to yield an algorithm with a worst-case complexity of O(n log n).
# Basically, MergeSort works like this:
# If we get a list of size 1, then it's already sorted: we're done. Just return that value.
# Otherwise; break the list you have to sort in half: 2a. MergeSort the first half. 2b. MergeSort the second half. 2c. "Merge" the two sorted lists for 2a and 2b together. Voila: sorted.
# 2c is where the MergeSort "merge" function comes in. It takes two already-sorted lists (arrays, in this example) and returns one large sorted list.
# The name of the function in this example is "mergesorted". It should return a big sorted array from two smaller sorted arrays: e.g.
# mergesorted([1,2],[3,4]) //should: [1,2,3,4]
# mergesorted([1,2],[3]) //should: [1,2,3]
# mergesorted([1],[2, 3]) //should: [1,2,3]

# My_answer
def merged(first, second)
  first.concat(second).sort!
end

# Best_answer
def merged(first, second)
final = []
  until first.length == 0 or second.length == 0
    if first[0] < second[0]
      final << first.shift
    else
      final << second.shift
    end
    
  end
  return final + first + second
end


# No.94
# Description:
# Write a function named first_non_repeating_letter that takes a string input,
# and returns the first character that is not repeated anywhere in the string.
# For example, if given the input 'stress', the function should return 't',
# since the letter t only occurs once in the string, and occurs first in the string.
# As an added challenge, upper- and lowercase letters are considered the same character,
# but the function should return the correct case for the initial letter. For example, the input 'sTreSS' should return 'T'.
# If a string contains all repeating characters, it should return an empty string ("") or None -- see sample tests.

# My_answer
def first_non_repeating_letter(s)
  s.chars.find{|char| s.downcase.count(char.downcase) <= 1} || ''
end

# Best_answer
def first_non_repeating_letter(s) 
  s.chars.find {|i| s.downcase.count(i)==1 || s.upcase.count(i)==1} || ""
end


# No.95
# Description:
# Build Tower
# Build Tower by the following given argument:
# number of floors (integer and always greater than 0).
# Tower block is represented as *
# Ruby: returns an Array;
# for example, a tower of 3 floors looks like below
# [
#   '  *  ', 
#   ' *** ', 
#   '*****'
# ]
# and a tower of 6 floors looks like below
# [
#   '     *     ', 
#   '    ***    ', 
#   '   *****   ', 
#   '  *******  ', 
#   ' ********* ', 
#   '***********'
# ]

# My_answer
def towerBuilder(n_floors)
  layer = width = n_floors + (n_floors - 1)
  result = []

  while layer > 0
    result.unshift(("*" * layer).center(width))
    layer -= 2
  end
  result
end

# Best_answer
def towerBuilder(n)
  (1..n).map do |i|
    space = ' ' * (n - i)
    stars = '*' * (i * 2 - 1)
    space + stars + space
  end
end


# No.96
# Description:
# Sudoku Background
# Sudoku is a game played on a 9x9 grid.
# The goal of the game is to fill all cells of the grid with digits from 1 to 9, so that each column, each row, and each of the nine 3x3 sub-grids (also known as blocks) contain all of the digits from 1 to 9.
# (More info at: http://en.wikipedia.org/wiki/Sudoku)
# Sudoku Solution Validator
# Write a function validSolution/ValidateSolution/valid_solution() that accepts a 2D array representing a Sudoku board, and returns true if it is a valid solution, or false otherwise.
# The cells of the sudoku board may also contain 0's, which will represent empty cells. Boards containing one or more zeroes are considered to be invalid solutions.
# The board is always 9 cells by 9 cells, and every cell only contains integers from 0 to 9.
# Examples
# validSolution([
#   [5, 3, 4, 6, 7, 8, 9, 1, 2],
#   [6, 7, 2, 1, 9, 5, 3, 4, 8],
#   [1, 9, 8, 3, 4, 2, 5, 6, 7],
#   [8, 5, 9, 7, 6, 1, 4, 2, 3],
#   [4, 2, 6, 8, 5, 3, 7, 9, 1],
#   [7, 1, 3, 9, 2, 4, 8, 5, 6],
#   [9, 6, 1, 5, 3, 7, 2, 8, 4],
#   [2, 8, 7, 4, 1, 9, 6, 3, 5],
#   [3, 4, 5, 2, 8, 6, 1, 7, 9]
# ]); // => true
# validSolution([
#   [5, 3, 4, 6, 7, 8, 9, 1, 2], 
#   [6, 7, 2, 1, 9, 0, 3, 4, 8],
#   [1, 0, 0, 3, 4, 2, 5, 6, 0],
#   [8, 5, 9, 7, 6, 1, 0, 2, 0],
#   [4, 2, 6, 8, 5, 3, 7, 9, 1],
#   [7, 1, 3, 9, 2, 4, 8, 5, 6],
#   [9, 0, 1, 5, 3, 7, 2, 1, 4],
#   [2, 8, 7, 4, 1, 9, 6, 3, 5],
#   [3, 0, 0, 4, 8, 1, 1, 7, 9]
# ]); // => false

# Best_answer
require 'set'

def validSolution(board)
  sudoku_sections = rows(board) + columns(board) + blocks(board)
  sudoku_sections.all?{|section| contains_all_nine?(section)}
end

# 行に分ける処理
def rows(board)
  board
end

# 列に分ける処理
def columns(board)
  board.transpose
end

# 3x3のブロックに分ける処理
def blocks(board)
  board.map do |row| 
    row.each_slice(3).to_a 
  end.transpose.flatten.each_slice(9).to_a
end

# 集合オブジェクトに変換し一致するか検証する
def contains_all_nine?(section)
  [1,2,3,4,5,6,7,8,9].to_set == section.to_set
end


# No.97
# Description:
# Complete the solution so that it strips all text that follows any of a set of comment markers passed in.
# Any whitespace at the end of the line should also be stripped out.
# Example:
# Given an input string of:
# apples, pears # and bananas
# grapes
# bananas !apples
# The output expected would be:
# apples, pears
# grapes
# bananas
# The code would be called like so:
# result = solution("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
# result should == "apples, pears\ngrapes\nbananas"

# Best_answer
# str.gsub(pattern, replacement)
# gsubメソッドの第1引数に正規表現のパターンpattern、第2引数に文字列replacementを指定すると、パターンにマッチする部分をすべてreplacementに置き換えた新しい文字列を返します。
def solution(input, markers)
  input.gsub(/\s+[#{markers.join}].*/, "")
end


# No.98
# Description:
# In this kata you have to create all permutations of an input string and remove duplicates, if present.
# This means, you have to shuffle all letters from the input in all possible orders.
# Examples:
# permutations('a'); # ['a']
# permutations('ab'); # ['ab', 'ba']
# permutations('aabb'); # ['aabb', 'abab', 'abba', 'baab', 'baba', 'bbaa']
# The order of the permutations doesn't matter.

# My_answer
def permutations(string)
  string.chars.permutation(string.length).map(&:join).uniq
end

# Best_answer
def permutations(string)
  string.chars.permutation.map(&:join).uniq
end


# No.99
# Description:
# A format for expressing an ordered list of integers is to use a comma separated list of either
# individual integers
# or a range of integers denoted by the starting integer separated from the end integer in the range by a dash, '-'.
# The range includes all integers in the interval including both endpoints. It is not considered a range unless it spans at least 3 numbers. For example ("12, 13, 15-17")
# Complete the solution so that it takes a list of integers in increasing order and returns a correctly formatted string in the range format.
# Example:
# solution([-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20])
# returns "-6,-3-1,3-5,7-11,14,15,17-20"

# Best_answer
def solution(list)
  # chunk_while {|elt_before, elt_after| ... } -> Enumerator
  # 要素を前から順にブロックで評価し、その結果によって要素をチャンクに分け た(グループ化した)要素を持つEnumerator を返します。
  # 隣り合う値をブロックパラメータ elt_before、elt_after に渡し、ブロックの 評価値が偽になる所でチャンクを区切ります。
  list.chunk_while { |n1, n2| n2 - n1 == 1 }
      .map { |set| set.size > 2 ? "#{set.first}-#{set.last}" : set }
      .join(',')
end


# No.100
# Description:
# Complete the function/method (depending on the language) to return true/True when its argument is an array that has the same nesting structure as the first array.
# For example:
# # should return true
# [ 1, 1, 1 ].same_structure_as( [ 2, 2, 2 ] )
# [ 1, [ 1, 1 ] ].same_structure_as( [ 2, [ 2, 2 ] ] )
# # should return false 
# [ 1, [ 1, 1 ] ].same_structure_as( [ [ 2, 2 ], 2 ] )
# [ 1, [ 1, 1 ] ].same_structure_as( [ [ 2 ], 2 ] )
# # should return true
# [ [ [ ], [ ] ] ].same_structure_as( [ [ [ ], [ ] ] ] ); 
# # should return false
# [ [ [ ], [ ] ] ].same_structure_as( [ [ 1, 1 ] ] )   

# My_answer(false)
class Array
  def same_structure_as(array)
    return false unless self.is_a?(Array) && array.is_a?(Array)
    self.map(&:class) == array.map(&:class) && self.flatten.length == array.flatten.length
  end
end

# Best_answer
class Array
  # 配列内の要素を全てnilに変換し、配列の構造だけを取り出す
  # 多重配列に対しては再帰処理を行う
  def structure
    map { |it| it.is_a?(Array) ? it.structure : nil }
  end
  
  def same_structure_as(arr)
    return false unless arr.is_a?(Array)
    structure == arr.structure
  end
end