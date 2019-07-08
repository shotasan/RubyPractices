# No.41
# Complete the solution so that it splits the string into pairs of two characters.
# If the string contains an odd number of characters then it should replace the missing second character of the final pair with an underscore ('_').
# Examples:
# solution('abc') # should return ['ab', 'c_']
# solution('abcdef') # should return ['ab', 'cd', 'ef']

# My_answer
def solution(str)
  str.scan(/.{1,2}/).map{ |str| str.size == 1 ? str + "_" : str }
end

# Best_answer
def solution str
  (str + '_').scan /../
end


# No.42
# You are given a list/array which contains only integers (positive and negative).
# Your job is to sum only the numbers that are the same and consecutive.
# The result should be one list.
# Extra credit if you solve it in one line.
# You can asume there is never an empty list/array and there will always be an integer.
# Same meaning: 1 == 1
# 1 != -1
# #Examples:
# [1,4,4,4,0,4,3,3,1] # should return [1,12,0,4,6,1]
# """So as you can see sum of consecutives 1 is 1 
# sum of 3 consecutives 4 is 12 
# sum of 0... and sum of 2 
# consecutives 3 is 6 ..."""
# [1,1,7,7,3] # should return [2,14,3]
# [-5,-5,7,7,12,0] # should return [-10,14,12,0]

# Best_answer
def sum_consecutives(s)
  # [Method]
  # chunk {|elt| ... } -> Enumerator
  # 要素を前から順にブロックで評価し、その結果によって 要素をチャンクに分けた(グループ化した)要素を持つ Enumerator を返します。
  # ブロックの評価値が同じ値が続くものを一つのチャンクとして 取り扱います。すなわち、ブロックの評価値が一つ前と 異なる所でチャンクが区切られます。
  
  # [Reading]
  # s.chunk {|n| n}で以下の配列が得られる。
  # [[1, [1]], [4, [4, 4, 4]], [0, [0]], [4, [4]], [3, [3, 3]], [1, [1]]]
  # .map(&:last)で上記配列の最後の要素（配列部分）を一つずつ取り出す。
  # .map {|group| group.reduce(:+)}で取り出した配列の合計値を返す。

  s.chunk {|n| n}.map(&:last).map {|group| group.reduce(:+)}
end


# No.43
# There is a queue for the self-checkout tills at the supermarket.
# Your task is write a function to calculate the total time required for all the customers to check out!
# input
# customers: an array of positive integers representing the queue.
# Each integer represents a customer, and its value is the amount of time they require to check out.
# n: a positive integer, the number of checkout tills.
# output
# The function should return an integer, the total time required.
# queue_time([5,3,4], 1)
# # should return 12
# # because when n=1, the total time is just the sum of the times
# queue_time([10,2,3,3], 2)
# # should return 10
# # because here n=2 and the 2nd, 3rd, and 4th people in the 
# # queue finish before the 1st person has finished.
# queue_time([2,3,10], 2)
# # should return 12

# Best_answer
def queue_time(customers, n)
  # n個の要素をもつ配列を作成する
  arr = Array.new(n, 0)
  # 配列の要素で最小の所にcustomerを入れていき、customersを全て格納した配列を作成する。
  # arr.index(arr.min)で配列内で最小の要素のインデックスを取得する
  customers.each do |customer|
     arr[arr.index(arr.min)] += customer 
  end
  # 作成した配列の最大値（最大作業時間）を取得する
  arr.max
end


# No.44
# For building the encrypted string:
# Take every 2nd char from the string, then the other chars, that are not every 2nd char, and concat them as new String.
# Do this n times!
# Examples:
# "This is a test!", 1 -> "hsi  etTi sats!"
# "This is a test!", 2 -> "hsi  etTi sats!" -> "s eT ashi tist!"
# For both methods:
# If the input-string is null or empty return exactly this value!
# If n is <= 0 then return the input text.

# My_answer(False)
def encrypt(text, n)
  return text if n <= 0

  if n == 0
    return encrypted_text
  else
    n -= 1
    encrypted_text = text.chars.partition.with_index{ |char, ind| ind.odd? }.join
    encrypt(encrypted_text, n)
  end
end

def decrypt(encrypted_text, n)
  return encrypted_text if n <= 0

  if n == 0
    return text
  else
    n -= 1
    text = encrypted_text.split(/(?=[A-Z])/).each{ |str| [str.chars] }
    byebug
    encrypted_text =text[1].chars.zip(text[0].chars).join
    decrypt(encrypted_text, n)
  end
end

# Best_answer
def encrypt(text, n)
  return text if n <= 0
  # scan(pattern) -> [String] | [[String]]
  # self に対して pattern を繰り返しマッチし、 マッチした部分文字列の配列を返します。
  # pattern が正規表現で括弧を含む場合は、 括弧で括られたパターンにマッチした部分文字列の配列の配列を返します。
  # transpose -> Array
  # 自身を行列と見立てて、行列の転置(行と列の入れ換え)を行いま す。転置した配列を生成して返します。空の配列に対しては空の配列を生 成して返します。
  # それ以外の一次元の配列に対しては、例外 TypeError が発生します。各要素のサイズが不揃いな配列に対して は、例外 IndexError が発生します。

  # scanメソッドで2文字づつの配列を作成し、transposeメソッドで1文字飛ばしの配列を作成する。

  encrypt(text.scan(/(.)(.)?/).transpose.reverse.join, n-1)
end

def decrypt(text, n)
  return text if n <= 0
  # sにはtextの長さを半分にした数値が入る
  c, s = text.chars, text.size/2
  # drop(n) -> Array
  # Enumerable オブジェクトの先頭の n 要素を捨てて、 残りの要素を配列として返します。
  # take(n) -> Array
  # Enumerable オブジェクトの先頭から n 要素を配列として返します。

  # c.drop(s)でtextを半分に分割した後半部分を取得する
  # c.take sでtextを半分に分割した前半部分を取得する

  decrypt(c.drop(s).zip(c.take s).join, n-1)
end


# No.45
# Write a function that accepts an array of 10 integers (between 0 and 9), that returns a string of those numbers in the form of a phone number.
# Example:
# createPhoneNumber(Array[1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) # => returns "(123) 456-7890"
# The returned format must be correct in order to complete this challenge. 
# Don't forget the space after the closing parenthesis!

# My_answer
def createPhoneNumber(numbers)
  result = []
  while numbers.count > 4
    result << numbers.take(3)
    numbers = numbers.drop(3)
  end
  result << numbers
  return "(#{ result[0].join }) #{ result[1].join }-#{ result[2].join }"
end

# Best_answer
# self % args -> String
# printf と同じ規則に従って args をフォーマットします。
# 整数を表す指示子: d
# numbersの要素が一つずつ%dに代入される
def createPhoneNumber(numbers)
  "(%d%d%d) %d%d%d-%d%d%d%d" % numbers
end


# No.45
# The word i18n is a common abbreviation of internationalization in the developer community,
# used instead of typing the whole word and trying to spell it correctly.
# Similarly, a11y is an abbreviation of accessibility.
# Write a function that takes a string and turns any and all "words" (see below) within that string of length 4 or greater into an abbreviation,
# following these rules:
# A "word" is a sequence of alphabetical characters.
# By this definition, any other character like a space or hyphen (eg. "elephant-ride") will split up a series of letters into two words (eg. "elephant" and "ride").
# The abbreviated version of the word should have the first letter, then the number of removed characters, then the last letter (eg. "elephant ride" => "e6t r2e").
# Example
# abbreviate("elephant-rides are really fun!")
# //          ^^^^^^^^*^^^^^*^^^*^^^^^^*^^^*
# // words (^):   "elephant" "rides" "are" "really" "fun"
# //                123456     123     1     1234     1
# // ignore short words:               X              X

# // abbreviate:    "e6t"     "r3s"  "are"  "r4y"   "fun"
# // all non-word characters (*) remain in place
# //                     "-"      " "    " "     " "     "!"
# === "e6t-r3s are r4y fun!"

# My_answer
class Abbreviator
  def self.abbreviate(string)
    words = self.new.make_words(string)
    non_words = self.new.make_non_words(string)
    words.zip(non_words).join
  end

  def make_words(string)
    string.scan(/[a-zA-Z]*[^, .-]/).map do |str|
      str.length > 3 ? str.gsub(/.(.+)./){ str[0] + $1.length.to_s + str[-1] } : str
    end
  end

  def make_non_words(string)
    string.scan(/[, .-]+/)
  end
end

# Best_answer
class Abbreviator
  def self.abbreviate(string)
    string.gsub /(\w)(\w+{2})(\w)/ do |word|
      "#{$1}#{word.length - 2}#{$3}" 
    end
  end
end


# No.46
# You will be given a number and you will need to return it as a string in Expanded Form. For example:
# expanded_form(12); # Should return '10 + 2'
# expanded_form(42); # Should return '40 + 2'
# expanded_form(70304); # Should return '70000 + 300 + 4'
# NOTE: All numbers will be whole numbers greater than 0.

# My_answer
def expanded_form(num)
  num.digits.map.with_index do |int, ind|
    int * ("1" + ("0" * ind)).to_i if int > 0
  end.compact.reverse.join(" + ")
end

# Best_answer
def expanded_form(num)
  num.to_s
     .chars
     .reverse
     .map.with_index { |d, idx| d.to_i * 10**idx }
     .reject(&:zero?)
     .reverse
     .join (' + ')
end