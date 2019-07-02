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
