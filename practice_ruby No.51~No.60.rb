# No.51
# You get an array of arrays.
# If you sort the arrays by their length, you will see, that their length-values are consecutive.
# But one array is missing!
# You have to write a method, that return the length of the missing array.
# Example:
# [[1, 2], [4, 5, 1, 1], [1], [5, 6, 7, 8, 9]] --> 3
# If the array of arrays is null/nil or empty, the method should return 0.
# When an array in the array is null or empty, the method should return 0 too!
# There will always be a missing element and its length will be always between the given arrays. 

# My_answer
def getLengthOfMissingArray(array_of_arrays)
  return 0 if array_of_arrays.nil? || array_of_arrays.empty? || array_of_arrays.any?{ |array| array == [] || array == nil }

  array_of_length = array_of_arrays.map(&:length)
  ([*array_of_length.min..array_of_length.max] - array_of_length).first
end

# Best_answer
def getLengthOfMissingArray(array_of_arrays)
  return 0 if array_of_arrays.nil?
  return 0 if array_of_arrays.empty?
  return 0 if array_of_arrays.any?{|arr| arr.nil?}
  return 0 if array_of_arrays.any?{|arr| arr.empty?}

  sorted = array_of_arrays.sort_by{|array| array.length}
  offset_idx = sorted.first.length
  sorted.each_with_index do |arr,idx|
    if arr.length != idx + offset_idx
      return sorted.index(arr) + offset_idx
    end
  end
end


# No.52
# Complete the solution so that the function will break up camel casing, using a space between words.
# Example
# solution('camelCasing') # => should return 'camel Casing'

# My_answer
def solution(string)
  string.gsub(/(?=[A-Z])/, ' ')
end

# Best_answer
def solution(string)
  string.gsub /([A-Z])/, ' \1'
end


# No.53
# The main idea is to count all the occuring characters(UTF-8) in string.
# If you have string like this aba then the result should be { 'a': 2, 'b': 1 }
# What if the string is empty ? Then the result should be empty object literal { }

# My_answer
def count_chars(s)
  table = Hash.new(0)
  s.scan(/./){ |chr| table[chr] += 1 }
  return table
end

# Best_answer
def count_chars(s)
  s.chars.uniq.each_with_object({}) { |c, h| h[c] = s.count(c) }
end


# No.54
# There is an array with some numbers. All numbers are equal except for one. Try to find it!
# find_uniq([ 1, 1, 1, 2, 1, 1 ]) == 2
# find_uniq([ 0, 0, 0.55, 0, 0 ]) == 0.55
# It’s guaranteed that array contains more than 3 numbers.
# The tests contain some very huge arrays, so think about performance.

# My_answer
def find_uniq(arr)
  arr.uniq.each do |num|
    return num unless arr.count(num) > 2
  end
end

# Best_answer
def find_uniq(arr)
  arr.uniq.each { |x| return x if arr.count(x) == 1 }
end


# No.55
# Given: an array containing hashes of names
# Return: a string formatted as a list of names separated by commas except for the last two names, which should be separated by an ampersand.
# Example:
# list([ {name: 'Bart'}, {name: 'Lisa'}, {name: 'Maggie'} ])
# # returns 'Bart, Lisa & Maggie'
# list([ {name: 'Bart'}, {name: 'Lisa'} ])
# # returns 'Bart & Lisa'
# list([ {name: 'Bart'} ])
# # returns 'Bart'
# list([])
# # returns ''

# My_answer
def list names
  name_array = names.map { |hash| hash[:name] }
  case name_array.size
  when 0
    return ''
  when 1
    return name_array.first
  else
    last_name = name_array.pop
    name_array.join(', ') + " & #{last_name}"
  end
end

# Best_answer
def list names
  names = names.map { |name| name[:name] }
  last_name = names.pop
  return last_name.to_s if names.empty?
  "#{names.join(', ')} & #{last_name}"
end


# No.56
# for i from 1 to n, do i % m and return the sum
# f(n=10, m=5) // returns 20 (1+2+3+4+0 + 1+2+3+4+0)
# You'll need to get a little clever with performance, since n can be a very large number

# My_answer(false)
def f(n,m)
  array = [*1..n]
  array.inject(0) do |result, int|
    result += int % m
  end
end

# Best_answer
def f(n, m)
  x, y = n.divmod(m)
  x * m * (m - 1) / 2 + y * (y + 1) / 2
end


# No.57
# Some numbers have funny properties. For example:
# 89 --> 8¹ + 9² = 89 * 1
# 695 --> 6² + 9³ + 5⁴= 1390 = 695 * 2
# 46288 --> 4³ + 6⁴+ 2⁵ + 8⁶ + 8⁷ = 2360688 = 46288 * 51
# Given a positive integer n written as abcd... (a, b, c, d... being digits) and a positive integer p
# we want to find a positive integer k, if it exists, such as the sum of the digits of n taken to the successive powers of p is equal to k * n.
# In other words:
# Is there an integer k such as : (a ^ p + b ^ (p+1) + c ^(p+2) + d ^ (p+3) + ...) = n * k
# If it is the case we will return k, if not return -1.
# Note: n and p will always be given as strictly positive integers.
# dig_pow(89, 1) should return 1 since 8¹ + 9² = 89 = 89 * 1
# dig_pow(92, 1) should return -1 since there is no k such as 9¹ + 2² equals 92 * k
# dig_pow(695, 2) should return 2 since 6² + 9³ + 5⁴= 1390 = 695 * 2
# dig_pow(46288, 3) should return 51 since 4³ + 6⁴+ 2⁵ + 8⁶ + 8⁷ = 2360688 = 46288 * 51

# My_answer
def dig_pow(n, p)
  numbers = n.digits.reverse
  sum_of_numbers = numbers.map.with_index(p){ |int, idx| int**idx }.sum
  
  if sum_of_numbers % n == 0
    sum_of_numbers / n
  else
    return -1
  end
end

# Best_answer
def dig_pow(n, p)
  total = n.to_s.split('').map.with_index{|d, i| d.to_i ** (p+i)}.reduce(:+)
  total % n == 0 ? (total / n) : -1
end


# No.58
# The goal of this exercise is to convert a string to a new string where each character in the new string is "("
# if that character appears only once in the original string, or ")" 
# if that character appears more than once in the original string.
# Ignore capitalization when determining if a character is a duplicate.
# Examples
# "din"      =>  "((("
# "recede"   =>  "()()()"
# "Success"  =>  ")())())"
# "(( @"     =>  "))((" 

# My_answer
def duplicate_encode(word)
  word.downcase.chars.map do |chr|
    word.downcase.count(chr) > 1 ? ")" : "("
  end.join
end

# Best_answer
def duplicate_encode(word)
  word
    .downcase
    .chars
    .map { |char| word.downcase.count(char) > 1 ? letter = ')' : letter = '(' }
    .join
end


# No.59
# Write a function that takes an integer as input,
# and returns the number of bits that are equal to one in the binary representation of that number.
# You can guarantee that input is non-negative.
# Example: The binary representation of 1234 is 10011010010, so the function should return 5 in this case

# My_answer
def count_bits(n)
  n.to_s(2).count('1')
end

# Best_answer
def count_bits(n)
  n.to_s(2).count "1"
end


# No.60
# Create a function taking a positive integer as its parameter and returning a string containing the Roman Numeral representation of that integer.
# Modern Roman numerals are written by expressing each digit separately starting with the left most digit and skipping any digit with a value of zero.
# In Roman numerals 1990 is rendered: 1000=M, 900=CM, 90=XC; resulting in MCMXC.
#                   2008 is written as 2000=MM, 8=VIII; or MMVIII.
#                   1666 uses each Roman symbol in descending order: MDCLXVI.
# Example:
# solution(1000) # should return 'M'
# Help:
# Symbol    Value
# I          1
# V          5
# X          10
# L          50
# C          100
# D          500
# M          1,000
# Remember that there can't be more than 3 identical symbols in a row.

# My_answer(false)
def solution(number)
  roman_numeral = { 1 => 'I', 4 => 'IV', 5=> 'V', 6 => 'VI', 10=> 'X', 50=> 'L', 100=> 'C', 500=> 'D', 1000=> 'M' }
  numbers = number.digits.map.with_index{ |int, idx| int * 10**idx }
  numbers.map{ |number| roman_numeral[number] }.reverse.join
end

# Best_answer
NUMERALS = { M: 1000, CM: 900, D: 500, CD: 400, C: 100, XC: 90,
               L: 50, XL: 40, X: 10, IX: 9, V: 5, IV: 4, I: 1 }

# numberがNUMERALSのvalue以上になった際に、keyを文字列として返す。
# numberからvalueを引いた数で再帰処理を繰り返す
def solution(number)
  return '' if number <= 0
  NUMERALS.each do |key, val| { return key.to_s + solution(number - val) if number >= val }
end
