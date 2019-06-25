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