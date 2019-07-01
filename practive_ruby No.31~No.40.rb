# No.31
# The GenericEntity class should allow any hash to be passed to its initializer which then creates instance variables and matching attribute readers for each key/value pair in the hash:
# box = GenericEntity.new(:shape => "square", :material => "cardboard")
# #box now has instance variables @shape and @material and attribute readers for both
# box.material #=> "cardboard"

# Best_answer
class GenericEntity
  def initialize(attrs = {})
    # 引数のハッシュを一つずつ取り出す
    # instance_variable_set("@#{attr}", value)でキー名のインスタンス変数を作成し、値を設定する
    # define_singleton_method(attr) { instance_variable_get("@#{attr}") }でキー名のメソッドを作成し、インスタンス変数にアクセスできるようにする
    attrs.each do |attr, value|
      # [メソッド]
      # define_singleton_method(symbol) { ... } -> Symbol
      # self に特異メソッド name を定義します。
      
      # instance_variable_get(var) -> object | nil
      # オブジェクトのインスタンス変数の値を取得して返します。
      # インスタンス変数が定義されていなければ nil を返します。

      # [内容]
      # define_singleton_method(attr)でキー名のメソッドを作成する
      # メソッドの内容はインスタンス変数を取得するだけ
      # instance_variable_get("@#{attr}")でインスタンス変数　@キー名でインスタンス変数を取得できるようになる
      define_singleton_method(attr) { instance_variable_get("@#{attr}") }
      # [メソッド]
      # instance_variable_set(var, value) -> object
      # オブジェクトのインスタンス変数 var に値 value を設定します。
      # インスタンス変数が定義されていなければ新たに定義されます。

      # [内容]
      # インスタンス変数を設定する
      # インスタンス変数@キー名にvalueを設定する
      instance_variable_set("@#{attr}", value)
    end
  end
end


# No.32
# In this kata you are required to, given a string, replace every letter with its position in the alphabet.
# If anything in the text isn't a letter, ignore it and don't return it.
# "a" = 1, "b" = 2, etc.
# Example
# alphabet_position("The sunset sets at twelve o' clock.")
# Should return "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11" (as a string)

# My_answer
def alphabet_position(text)
  text.downcase.delete("^a-z").chars.map{ |chr| chr.ord - 96 }.join(" ")
end

# Best_answer
def alphabet_position(text)
  text.gsub(/[^a-z]/i, '').chars.map{ |c| c.downcase.ord - 96 }.join(' ')
end


# No.33
# You have an array of numbers.
# Your task is to sort ascending odd numbers but even numbers must be on their places.
# Zero isn't an odd number and you don't need to move it. If you have an empty array, you need to return it.
# Example
# sort_array([5, 3, 2, 8, 1, 4]) == [1, 3, 2, 8, 5, 4]

# Best_answer
def sort_array(xs)
  # 奇数だけをソートしたEnumeratorオブジェクトを作成する
  odd = xs.select(&:odd?).sort.each
  # next -> object 「次」のオブジェクトを返します。現在までの列挙状態に応じて「次」のオブジェクトを返し、列挙状態を1つ分進めます。
  # mapを使い、奇数ならソートしたEnumeratorオブジェクトから順に取り出す。偶数ならそのまま。
  xs.map{ |x| x.odd? ? odd.next : x }
end


# No.34
# Write a function that takes a string of braces,and determines if the order of the braces is valid.
# It should return true if the string is valid, and false if it's invalid.
# All input strings will be nonempty, and will only consist of parentheses, brackets and curly braces: ()[]{}.
# "(){}[]"   =>  True
# "([{}])"   =>  True
# "(}"       =>  False
# "[(])"     =>  False
# "[({})](]" =>  False

# Best_answer
BRACES = { "(" => ")", "[" => "]", "{" => "}" }
# 括弧開きから括弧閉じの配列を作成し、括弧閉じが正しい順番で出現していれば、配列から要素を削除していきtrueを判定する
def validBraces(braces)
  # each_char -> Enumerator
  # 文字列の各文字に対して繰り返します。
  # each_with_object(obj) {|(*args), memo_obj| ... } -> object
  # 与えられた任意のオブジェクトと要素をブロックに渡し繰り返し、最初に与えられたオブジェクトを返します。
  braces.each_char.each_with_object([]) { |char, stack|
    case char
    # BRACESのキーなら配列stackの最後に値を入れる
    # stackには閉じ括弧だけが入る
    when *BRACES.keys
      stack.push(BRACES[char])
    # BRACESのvalue場合、stackの最後と等しく無ければfalseを返す
    # 等しければstackの最後を削除することで開き括弧と閉じ括弧の関係を検証する
    when *BRACES.values
      return false unless stack.last == char
      stack.pop
    end
    # 全て削除されればtrueを返す
  }.empty?
end


# No.35
# A child is playing with a ball on the nth floor of a tall building.
# The height of this floor, h, is known.
# He drops the ball out of the window. The ball bounces (for example), to two-thirds of its height (a bounce of 0.66).
# His mother looks out of a window 1.5 meters from the ground.
# How many times will the mother see the ball pass in front of her window (including when it's falling and bouncing?
# Three conditions must be met for a valid experiment:
# Float parameter "h" in meters must be greater than 0
# Float parameter "bounce" must be greater than 0 and less than 1
# Float parameter "window" must be less than h.
# If all three conditions above are fulfilled, return a positive integer, otherwise return -1.
# Note:
# The ball can only be seen if the height of the rebounding ball is stricty greater than the window parameter.
# Example:
# - h = 3, bounce = 0.66, window = 1.5, result is 3
# - h = 3, bounce = 1, window = 1.5, result is -1 
# (Condition 2) not fulfilled).

# My_answer
def bouncingBall(h, bounce, window)
  if h < 0 || bounce >= 1 || bounce < 0 || window >= h
    return -1
  end

  result = 0
  while h * bounce > window
    result += 2
    h *= bounce
  end
  return result + 1
end

# Best_answer
def bouncingBall(h, bounce, window)
  bounce < 0 || bounce >= 1 || h <= window || window < 0 ? -1 : bouncingBall(h * bounce, bounce, window) + 2
end


# No.36
# Write a function toWeirdCase (weirdcase in Ruby) that accepts a string,
# and returns the same string with all even indexed characters in each word upper cased,
# and all odd indexed characters in each word lower cased.
# The indexing just explained is zero based, so the zero-ith index is even, therefore that character should be upper cased.
# The passed in string will only consist of alphabetical characters and spaces(' ').
# Spaces will only be present if there are multiple words. Words will be separated by a single space(' ').
# weirdcase( "String" )#=> returns "StRiNg"
# weirdcase( "Weird string case" );#=> returns "WeIrD StRiNg CaSe"

# My_answer
def weirdcase string
  result = []
  string.split(" ").each do |string|
    count = 0
    string.chars.each do |str|
      if str == " "
        result << str
      elsif
        count.even?
        result << str.upcase
        count += 1
      else
        result << str.downcase
        count += 1
      end
    end
    result << " "
  end
  result.join.chop
end

# Best_answer
def weirdcase(string)
  string.split(' ').map do |word|
    word.split('').each_with_index.map do |char, i|
      i % 2 == 0 ? char.upcase : char.downcase
    end.join('')
  end.join(' ')
end


# No.37
# Given a number, return a string with dash'-'marks before and after each odd integer, but do not begin or end the string with a dash mark.
# Ex:
# dashatize(274) -> '2-7-4'
# dashatize(6815) -> '68-1-5'

# Best_answer
def dashatize(num)
  # scan(pattern) -> [String] | [[String]]
  # self に対して pattern を繰り返しマッチし、 マッチした部分文字列の配列を返します。
  # pattern が正規表現で括弧を含む場合は、 括弧で括られたパターンにマッチした部分文字列の配列の配列を返します。
  num ? num.to_s.scan(/[02468]+|[13579]/).join("-") : "nil"
end


# No.38
# The input is a string str of digits.
# Cut the string into chunks (a chunk here is a substring of the initial string) of size sz (ignore the last chunk if its size is less than sz).
# If a chunk represents an integer such as the sum of the cubes of its digits is divisible by 2,
# reverse that chunk; otherwise rotate it to the left by one position. Put together these modified chunks and return the result as a string.
# revrot("123456987654", 6) --> "234561876549"
# revrot("123456987653", 6) --> "234561356789"
# revrot("66443875", 4) --> "44668753"
# revrot("66443875", 8) --> "64438756"
# revrot("664438769", 8) --> "67834466"
# revrot("123456779", 8) --> "23456771"
# revrot("", 8) --> ""
# revrot("123456779", 0) --> "" 
# revrot("563000655734469485", 4) --> "0365065073456944"

# Best_answer
def revrot(str, sz)
  return '' if sz <= 0
  # 文字数を指定して、文字列を分割する
  chunks = str.scan(/.{#{sz}}/)
  # 分割した文字列ごとに各数値の３乗の合計を計算し、偶数か奇数を判定する
  chunks.map do |chunk|
    digits = chunk.chars
    sum = digits.map {|x| x.to_i ** 3 }.inject(:+)
    sum.even? ? digits.reverse : digits.rotate
  end.join
end


# No.39
# Write a function that will return the count of distinct case-insensitive alphabetic characters and numeric digits that occur more than once in the input string. 
# The input string can be assumed to contain only alphabets (both uppercase and lowercase) and numeric digits.
# Example
# "abcde" -> 0 # no characters repeats more than once
# "aabbcde" -> 2 # 'a' and 'b'
# "aabBcde" -> 2 # 'a' occurs twice and 'b' twice (`b` and `B`)
# "indivisibility" -> 1 # 'i' occurs six times
# "Indivisibilities" -> 2 # 'i' occurs seven times and 's' occurs twice
# "aA11" -> 2 # 'a' and '1'
# "ABBA" -> 2 # 'A' and 'B' each occur twice

# My_answer
def duplicate_count(text)
  count = 0
  text.downcase.chars.uniq.each do |char|
    count += 1 if text.downcase.chars.count(char) > 1
  end
  count
end

# Best_answer
def duplicate_count(text)
  # count {|obj| ... } -> Integer
  # ブロックを指定した場合は、ブロックを評価して真になった要素の個数を カウントして返します。
  ('a'..'z').count { |c| text.downcase.count(c) > 1 }
end


# No.40
# John has invited some friends. His list is:
# s = "Fred:Corwill;Wilfred:Corwill;Barney:Tornbull;Betty:Tornbull;Bjon:Tornbull;Raphael:Corwill;Alfred:Corwill";
# Could you make a program that
# makes this string uppercase
# gives it sorted in alphabetical order by last name.
# When the last names are the same, sort them by first name.
# Last name and first name of a guest come in the result between parentheses separated by a comma.
# So the result of function meeting(s) will be:
# "(CORWILL, ALFRED)(CORWILL, FRED)(CORWILL, RAPHAEL)(CORWILL, WILFRED)(TORNBULL, BARNEY)(TORNBULL, BETTY)(TORNBULL, BJON)"
# It can happen that in two distinct families with the same family name two people have the same first name too.

# My_answer
def meeting(s)
  upcase_and_sort(s).map { |last, first| "(" + last + ", " + first + ")" }.join
end

def upcase_and_sort(s)
  names = s.split(";").map { |name| name.split(":") }
  names.map { |first, last| [last.upcase, first.upcase] }.sort
end

# Best_answer
def meeting(s)
  names =
    s
      .upcase
      .split(";")
      .map { |name| name.split(":") }
      .sort_by { |name, last| [last, name] }
      .map { |name, last| "(#{last}, #{name})" }
      .join
end


# No.41
# A Narcissistic Number is a number which is the sum of its own digits, each raised to the power of the number of digits in a given base.
# In this Kata, we will restrict ourselves to decimal (base 10).
# For example, take 153 (3 digits):
#     1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153
# and 1634 (4 digits):
#     1^4 + 6^4 + 3^4 + 4^4 = 1 + 1296 + 81 + 256 = 1634
# The Challenge:
# Your code must return true or false depending upon whether the given number is a Narcissistic number in base 10.
# Error checking for text strings or other invalid inputs is not required, only valid integers will be passed into the function.

# My_answer
def narcissistic?(value)
  !!(value.digits.map{ |num| num ** value.digits.size }.sum == value)
end

# Best_answer
def narcissistic?( value )
  value == value.to_s.chars.map { |x| x.to_i**value.to_s.size }.reduce(:+)
end