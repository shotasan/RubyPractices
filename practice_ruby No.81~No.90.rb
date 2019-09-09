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