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


# No.67
# Write a program that will calculate the number of trailing zeros in a factorial of a given number.
# N! = 1 * 2 * 3 * ... * N
# Be careful 1000! has 2568 digits...
# Examples
# zeros(6) = 1
# # 6! = 1 * 2 * 3 * 4 * 5 * 6 = 720 --> 1 trailing zero
# zeros(12) = 2
# # 12! = 479001600 --> 2 trailing zeros
# Hint: You're not meant to calculate the factorial. Find another way to find the number of zeros.

# My_answer
def zeros(n)
  count_zero = 0
  i = 1
  while n / (5**i) > 0
    count_zero += n / (5**i)
    i += 1
  end
  count_zero
end

# Best_answer
def zeros(n)
  n < 5 ? 0 : (n / 5) + zeros(n / 5)
end


# No.68
# The prime numbers are not regularly spaced. For example from 2 to 3 the gap is 1. From 3 to 5 the gap is 2. From 7 to 11 it is 4.
# Between 2 and 50 we have the following pairs of 2-gaps primes: 3-5, 5-7, 11-13, 17-19, 29-31, 41-43
# A prime gap of length n is a run of n-1 consecutive composite numbers between two successive primes (see: http://mathworld.wolfram.com/PrimeGaps.html).
# We will write a function gap with parameters:
# g (integer >= 2) which indicates the gap we are looking for
# m (integer > 2) which gives the start of the search (m inclusive)
# n (integer >= m) which gives the end of the search (n inclusive)
# In the example above gap(2, 3, 50) will return [3, 5] or (3, 5) or {3, 5} which is the first pair between 3 and 50 with a 2-gap.
# So this function should return the first pair of two prime numbers spaced with a gap of g between the limits m, n
# if these numbers exist otherwise nil or null or None or Nothing (depending on the language).
# #Examples: gap(2, 5, 7) --> [5, 7] or (5, 7) or {5, 7}
# gap(2, 5, 5) --> nil
# gap(4, 130, 200) --> [163, 167] or (163, 167) or {163, 167}
# ([193, 197] is also such a 4-gap primes between 130 and 200 but it's not the first pair)
# gap(6,100,110) --> nil or {0, 0} : between 100 and 110 we have 101, 103, 107, 109 but 101-107is not a 6-gap because there is 103in between and 103-109is not a 6-gap because there is 107in between.

# My_answer(false: TimeOut)
def gap(g, m, n)
  require 'prime'

  Prime.each(n).select{|i| i >= m}.each_cons(2).prime.find{|p, r| r - p == g}
end

# Best_answer
def gap(g, m, n)
  (m..n).to_a.each do |i|
    # (i+1...i+g).to_a.none?{|e| e.prime?}
    # i = 101, i+g = 107をfalseにするための記述
    return [i, i+g] if i.prime? and (i+g).prime? and (i+1...i+g).to_a.none?{|e| e.prime?}
  end

  return nil
end


# No.69
# The rgb() method is incomplete. Complete the method so that passing in RGB decimal values will result in a hexadecimal representation being returned.
# The valid decimal values for RGB are 0 - 255. Any (r,g,b) argument values that fall out of that range should be rounded to the closest valid value.
# The following are examples of expected output values:
# rgb(255, 255, 255) # returns FFFFFF
# rgb(255, 255, 300) # returns FFFFFF
# rgb(0,0,0) # returns 000000
# rgb(148, 0, 211) # returns 9400D3

# My_answer
def rgb(r, g, b)  
  [r, g, b].map do |i|
    i = 0 if i.negative?
    i = 255 if i > 255
    i.to_s(16).rjust(2, "0")
  end.join.upcase
end

# Best_answer
# self % args -> String
# printf と同じ規則に従って args をフォーマットします。

# args
# [i,255].minで255より大きい数字を排除する
# [[i,255].min, 0]でマイナスを０に変換する
# [[i,255].min, 0].maxで目的の数値を得る

# self
# %.2で2桁に限定する
# Xで大文字の16進数にする

def rgb(r, g, b)
  "%.2X%.2X%.2X" % [r,g,b].map{|i| [[i,255].min,0].max}
end


# No.70
# A friend of mine takes a sequence of numbers from 1 to n (where n > 0).
# Within that sequence, he chooses two numbers, a and b.
# He says that the product of a and b should be equal to the sum of all numbers in the sequence, excluding a and b.
# Given a number n, could you tell me the numbers he excluded from the sequence?
# The function takes the parameter: n (n is always strictly greater than 0) and returns an array or a string (depending on the language) of the form:
# [(a, b), ...] or [[a, b], ...] or {{a, b}, ...} or or [{a, b}, ...]
# with all (a, b) which are the possible removed numbers in the sequence 1 to n.
# [(a, b), ...] or [[a, b], ...] or {{a, b}, ...} or ...will be sorted in increasing order of the "a".
# It happens that there are several possible (a, b).
# The function returns an empty array (or an empty string) if no possible numbers are found which will prove that my friend has not told the truth! (Go: in this case return nil).
# (See examples of returns for each language in "RUN SAMPLE TESTS")
# Examples:
# removeNb(26) should return [[15, 21], [21, 15]]
# removNb(100) should return []

# My_answer(false: TimeOut)
def removNb(n)
  sum_of_sequence = (1..n).inject(:+)
  combinations = [*1..n].combination(2).to_a
  combinations.each do |a, b|
    return [[a, b], [b, a]] if sum_of_sequence == (a * b) + a + b 
  end
  []
end

# Best_answer
# generate a range from 1 to n
# use an iterator/each over the range we generated to get our first number
# nest an iterator over range move the number up to get every possible number of pairs
# while inside second iterator, we are going to remove the two numbers from the array
# sum the resulting number test for equality under two numbers
# append to some sort of results array

# total = (n*n + n) /2
# (total - a - b) = ab
# (total - a) = ab + b = b(a+1) 
# ((total - a) / (a+1)) = b

def removNb(n)
  res = []
  total = (n*n + n) / 2
  range = (1..n)
  
  (1..n).each do |a|
    b = ((total - a) / (a * 1.0 + 1.0))
    if b == b.to_i && b <= n
      res.push([a,b.to_i])
    end
  end

  return res
end