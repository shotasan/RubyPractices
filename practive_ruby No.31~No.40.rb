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