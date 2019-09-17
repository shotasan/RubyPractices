# No.81
# Description:
# Complete the function/method so that it takes CamelCase string and returns the string in snake_case notation.
# Lowercase characters can be numbers. If method gets number, it should return string.
# Examples:
# # returns test_controller
# to_underscore('TestController')
# # returns movies_and_books
# to_underscore('MoviesAndBooks')
# # returns app7_test
# to_underscore('App7Test')
# # returns "1"
# to_underscore(1)

# My_answer
def to_underscore(string)
  string.split(/(?=[A-Z])/).map(&:downcase).join("_")
end

# Best_answer
def to_underscore(string)
  string.to_s.split(/(?=[A-Z])/).join('_').downcase
end


# No.82
# Consider the following numbers (where n! is factorial(n)):
# u1 = (1 / 1!) * (1!)
# u2 = (1 / 2!) * (1! + 2!)
# u3 = (1 / 3!) * (1! + 2! + 3!)
# un = (1 / n!) * (1! + 2! + 3! + ... + n!)
# Which will win: 1 / n! or (1! + 2! + 3! + ... + n!)?
# Are these numbers going to 0 because of 1/n! or to infinity due to the sum of factorials or to another number?
# Task
# Calculate (1 / n!) * (1! + 2! + 3! + ... + n!) for a given n, where n is an integer greater or equal to 1.
# To avoid discussions about rounding, return the result truncated to 6 decimal places, for example:
# 1.0000989217538616 will be truncated to 1.000098
# 1.2125000000000001 will be truncated to 1.2125
# Remark
# Keep in mind that factorials grow rather rapidly, and you need to handle large inputs.
# Test.assert_equals(going(5), 1.275)
# Test.assert_equals(going(6), 1.2125)
# Test.assert_equals(going(7), 1.173214)

# Best_answer
# n = 5の場合、4!/5!= 1/5, 3!/5!= 1/20, 2!/5!= 1/60, 1!/5!= 1/120
# 各階乗をn!で割った合計値をresとして返す
def going(n)
  res,div=0,1
  n.times do |i|
    res+=1.0/div
    div*=n-i
  end
  return (res*1000000).floor/1000000.0
end


# No.83
# Given an array (arr) as an argument complete the function countSmileys that should return the total number of smiling faces.
# Rules for a smiling face:
# -Each smiley face must contain a valid pair of eyes. Eyes can be marked as : or ;
# -A smiley face can have a nose but it does not have to. Valid characters for a nose are - or ~
# -Every smiling face must have a smiling mouth that should be marked with either ) or D.
# No additional characters are allowed except for those mentioned.
# Valid smiley face examples:
# :) :D ;-D :~)
# Invalid smiley faces:
# ;( :> :} :] 
# Example cases:
# countSmileys([':)', ';(', ';}', ':-D']);       // should return 2;
# countSmileys([';D', ':-(', ':-)', ';~)']);     // should return 3;
# countSmileys([';]', ':[', ';*', ':$', ';-D']); // should return 1;
# Note: In case of an empty array return 0. You will not be tested with invalid input (input will always be an array). 
# Order of the face (eyes, nose, mouth) elements will always be the same

# My_answer
def count_smileys(arr)
  arr.map{|item| item.match(/[:;][-~]*[)D]/)}.compact.count
end

# Best_answer
def count_smileys(arr)
  arr.count { |e| e =~ /(:|;){1}(-|~)?(\)|D)/ }
end


# No.84
# ROT13 is a simple letter substitution cipher that replaces a letter with the letter 13 letters after it in the alphabet.
# ROT13 is an example of the Caesar cipher.
# Create a function that takes a string and returns the string ciphered with Rot13.
# If there are numbers or special characters included in the string, they should be returned as they are.
# Only letters from the latin/english alphabet should be shifted, like in the original Rot13 "implementation".

# Best_answer
# tr(pattern, replace) -> String
# pattern 文字列に含まれる文字を検索し、 それを replace 文字列の対応する文字に置き換えます。
# pattern の形式は tr(1) と同じです。つまり、 `a-c' は a から c を意味し、"^0-9" のように 文字列の先頭が `^' の場合は指定文字以外が置換の対象になります。
# replace に対しても `-' による範囲指定が可能です。 例えば String#upcase は tr を使って "foo".tr('a-z', 'A-Z') と書けます。
# `-' は文字列の両端にない場合にだけ範囲指定の意味になります。 `^' も文字列の先頭にあるときにだけ否定の効果を発揮します。 また、`-', `^', `\' はバックスラッシュ (`\') によりエスケープできます。
# replace の範囲が pattern の範囲よりも小さい場合は、 replace の最後の文字が無限に続くものとして扱われます。
def rot13(string)
  string.tr("A-Za-z", "N-ZA-Mn-za-m")
end


# No.85
# Your task in order to complete this Kata is to write a function which formats a duration, given as a number of seconds, in a human-friendly way.
# The function must accept a non-negative integer. If it is zero, it just returns "now". Otherwise, the duration is expressed as a combination of years, days, hours, minutes and seconds.
# It is much easier to understand with an example:
# format_duration(62)    # returns "1 minute and 2 seconds"
# format_duration(3662)  # returns "1 hour, 1 minute and 2 seconds"
# For the purpose of this Kata, a year is 365 days and a day is 24 hours.
# Note that spaces are important.
# Detailed rules
# The resulting expression is made of components like 4 seconds, 1 year, etc. In general, a positive integer and one of the valid units of time, separated by a space.
# The unit of time is used in plural if the integer is greater than 1.
# The components are separated by a comma and a space (", "). Except the last component, which is separated by " and ", just like it would be written in English.
# A more significant units of time will occur before than a least significant one. Therefore, 1 second and 1 year is not correct, but 1 year and 1 second is.
# Different components have different unit of times. So there is not repeated units like in 5 seconds and 1 second.
# A component will not appear at all if its value happens to be zero. Hence, 1 minute and 0 seconds is not valid, but it should be just 1 minute.
# A unit of time must be used "as much as possible". It means that the function should not return 61 seconds, but 1 minute and 1 second instead.
# Formally, the duration specified by of a component must not be greater than any valid more significant unit of time.

# My_answer(false)
def format_duration(seconds)
  check(seconds, result=[])
  result
end

def check(seconds, result)
  if seconds >= 60
    quotient_surplus = seconds.divmod(60)
    result.unshift(quotient_surplus[1])
    check(quotient_surplus[0], result)
  else
    result.unshift(seconds)
  end

  if result.length < 3
    until result.length == 3
      result.unshift(0)
    end
  end
  result
end

# Best_answer
def format_duration(total)
  if total == 0
    "now"
  else
    duration = {
      year:   total / (60 * 60 * 24 * 365),
      day:    total / (60 * 60 * 24) % 365,
      hour:   total / (60 * 60) % 24,
      minute: total / 60 % 60,
      second: total % 60
    }
  
    @output = []
  
    duration.each do |key, value|
      if value > 0
        @output << "#{value} #{key}"
        @output.last << "s" if value != 1
      end
    end
  
    @output.join(', ').gsub(/\,\s(?=\d+\s\w+$)/, " and ")
  end
end


# NO.86
# Given an n x n array, return the array elements arranged from outermost elements to the middle element, traveling clockwise.
# array = [[1,2,3],
#          [4,5,6],
#          [7,8,9]]
# snail(array) #=> [1,2,3,6,9,8,7,4,5]
# For better understanding, please follow the numbers of the next array consecutively:
# array = [[1,2,3],
#          [8,9,4],
#          [7,6,5]]
# snail(array) #=> [1,2,3,4,5,6,7,8,9]
# NOTE: The idea is not sort the elements from the lowest value to the highest; the idea is to traverse the 2-d array in a clockwise snailshell pattern.
# NOTE 2: The 0x0 (empty matrix) is represented as [[]]

# Best_answer
# 横、縦、横と組み合わせを作成し、順に結合していく
# transpose -> Array
# 自身を行列と見立てて、行列の転置(行と列の入れ換え)を行いま す。転置した配列を生成して返します。空の配列に対しては空の配列を生 成して返します。
def snail(array)
  if array.empty?
     []
  else
    array.shift + snail(array.transpose.reverse)
  end
end
