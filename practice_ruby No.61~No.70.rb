# No.61
# The number 89 is the first integer with more than one digit that fulfills the property partially introduced in the title of this kata.
# What's the use of saying "Eureka"? Because this sum gives the same number.
# In effect: 89 = 8^1 + 9^2
# The next number in having this property is 135.
# See this property again: 135 = 1^1 + 3^2 + 5^3
# We need a function to collect these numbers,
# that may receive two integers a, b that defines the range [a, b] (inclusive) and
# outputs a list of the sorted numbers in the range that fulfills the property described above.
# Let's see some cases:
# sum_dig_pow(1, 10) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
# sum_dig_pow(1, 100) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 89]
# If there are no numbers of this kind in the range [a, b] the function should output an empty list.
# sum_dig_pow(90, 100) == []

# My_answer
def sum_dig_pow(a, b)
  sum_of_digits(a, b).select.with_index(a){ |int, idx| int == idx }
end

def sum_of_digits(a, b)
  [*a..b].map do |int|
    int.digits.reverse.map.with_index do |int, idx|
      int**(idx+1)
    end.sum
  end
end

# Best_answer
def sum_dig_pow(a, b)
  (a...b).select { |n| n == n.to_s.chars.map.with_index(1) { |e, i| e.to_i ** i }.reduce(:+) }
end


# No.62
# A string is considered to be in title case if each word in the string is either
# (a) capitalised (that is, only the first letter of the word is in upper case) or
# (b) considered to be an exception and put entirely into lower case unless it is the first word, which is always capitalised.
# Write a function that will convert a string into title case, given an optional list of exceptions (minor words).
# The list of minor words will be given as a string with each word separated by a space.
# Your function should ignore the case of the minor words string -- it should behave in the same way even if the case of the minor word string is changed.
# First argument (required): the original string to be converted.
# Second argument (optional): space-delimited list of minor words that must always be lowercase except for the first word in the string.
# ###Example
# title_case('a clash of KINGS', 'a an the of') # should return: 'A Clash of Kings'
# title_case('THE WIND IN THE WILLOWS', 'The In') # should return: 'The Wind in the Willows'
# title_case('the quick brown fox') # should return: 'The Quick Brown Fox'

# My_answer
def title_case(title, minor_words = '')
  return '' if title.empty?
  
  title.downcase.split(' ').map.with_index do |word, idx|
    minor_words.downcase.split(' ').include?(word) && idx != 0 ? word : word.capitalize
  end.join(' ')
end

# Best_answer
def title_case(title, minor_words = '')
  title.capitalize.split().map{|a| minor_words.downcase.split().include?(a) ? a : a.capitalize}.join(' ')
end


# No.63
# My friend John and I are members of the "Fat to Fit Club (FFC)". 
# John is worried because each month a list with the weights of members is published and each month he is the last on the list which means he is the heaviest.
# I am the one who establishes the list so I told him: "Don't worry any more, I will modify the order of the list".
# It was decided to attribute a "weight" to numbers. The weight of a number will be from now on the sum of its digits.
# For example 99 will have "weight" 18, 100 will have "weight" 1 so in the list 100 will come before 99.
# Given a string with the weights of FFC members in normal order can you give this string ordered by "weights" of these numbers?
# Example:
# "56 65 74 100 99 68 86 180 90" ordered by numbers weights becomes: "100 180 90 56 65 74 68 86 99"
# When two numbers have the same "weight",
# let us class them as if they were strings and not numbers: 100 is before 180 because its "weight" (1) is less than the one of 180 (9) and 180 is before 90 since,
# having the same "weight" (9), it comes before as a string.
# All numbers in the list are positive numbers and the list can be empty.

# My_answer(False)
def order_weight(strng)
  strng.split.sort_by(&:to_s).sort_by{ |v| v.to_i.digits.inject(:+) }.join(' ')
end

# Best_answer
def order_weight(string)
  string.split.sort_by { |n| [n.chars.map(&:to_i).reduce(:+), n] }.join(" ")
end


# No.64
# The maximum sum subarray problem consists in finding the maximum sum of a contiguous subsequence in an array or list of integers:
# maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
# -- should be 6: [4, -1, 2, 1]
# Easy case is when the list is made up of only positive numbers and the maximum sum is the sum of the whole array.
# If the list is made up of only negative numbers, return 0 instead.
# Empty list is considered to have zero greatest sum. Note that the empty list or array is also a valid sublist/subarray.

# My_answer
def max_sequence(arr)
  return 0 if arr.empty? || arr.all?(&:negative?)

  result = []
  1.upto(arr.size) { |n| result << arr.each_cons(n).map(&:sum).max }
  result.max
end

# Best_answer
def max_sequence(array)
  (1..array.size).map { |i| array.each_cons(i).map(&:sum) }.flatten.push(0).max
end


# No.65
# Sheldon, Leonard, Penny, Rajesh and Howard are in the queue for a "Double Cola" drink vending machine;
# there are no other people in the queue. The first one in the queue (Sheldon) buys a can, drinks it and doubles!
# The resulting two Sheldons go to the end of the queue. Then the next in the queue (Leonard) buys a can,
# drinks it and gets to the end of the queue as two Leonards, and so on.
# For example, Penny drinks the third can of cola and the queue will look like this:
# Rajesh, Howard, Sheldon, Sheldon, Leonard, Leonard, Penny, Penny
# Write a program that will return the name of the person who will drink the n-th cola.
# Input
# The input data consist of an array which contains at least 1 name,
# and single integer n which may go as high as the biggest number your language of choice supports (if there's such limit, of course).
# Output / Examples
# Return the single line — the name of the person who drinks the n-th can of cola. The cans are numbered starting from 1.
# whoIsNext(["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"], 1) == "Sheldon"
# whoIsNext(["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"], 52) == "Penny"
# whoIsNext(["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"], 7230702951) == "Leonard"

# Best_answer
def whoIsNext(names, r)
  r -= 1
  while r >= names.size
    r -= names.size
    r /= 2
  end
  names[r]
end


# No.66
# Divisors of 42 are : 1, 2, 3, 6, 7, 14, 21, 42. These divisors squared are: 1, 4, 9, 36, 49, 196, 441, 1764. 
# The sum of the squared divisors is 2500 which is 50 * 50, a square!
# Given two integers m, n (1 <= m <= n) we want to find all integers between m and n whose sum of squared divisors is itself a square. 42 is such a number.
# The result will be an array of arrays or of tuples (in C an array of Pair) or a string, each subarray having two elements,
# first the number whose squared divisors is a square and then the sum of the squared divisors.
# #Examples:
# list_squared(1, 250) --> [[1, 1], [42, 2500], [246, 84100]]
# list_squared(42, 250) --> [[42, 2500], [246, 84100]]
# The form of the examples may change according to the language, see Example Tests: for more details.

# My_answer
def list_squared(m, n)
  divisors_itself_square(m, n).map{ |result| [result[1], divisors_sum(result[1])]}
end

def divisors_itself_square(m, n)
  (m..n).map.with_index(m) do |int, idx|
    [Math.sqrt(divisors_sum(int)), idx]
  end.select{ |num| num[0] % 1 == 0 }
end

def divisors_sum(n)
  n.prime_division.inject([1]) do |ary, (p, e)|
    (0..e).map{ |e1| p ** e1 }.product(ary).map{ |a, b| a * b }
  end.map{ |i| i * i }.sum
end

# Best_answer
# compact -> Array
# compact は自身から nil を取り除いた配列を生成して返します。 compact! は自身から破壊的に nil を取り除き、変更が 行われた場合は self を、そうでなければ nil を返します。

def list_squared(m, n)
(m..n).map do |num|
  divisors = (1..num).select {|i| num % i == 0}
  sum_divisors_sq = divisors.map {|i| i ** 2}.inject(:+)
  [num, sum_divisors_sq] if Math.sqrt(sum_divisors_sq) % 1 == 0
  end.compact
end
