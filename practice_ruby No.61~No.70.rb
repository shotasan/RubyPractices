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