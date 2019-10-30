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