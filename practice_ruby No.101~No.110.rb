# No.101
# Description:
# A bookseller has lots of books classified in 26 categories labeled A, B, ... Z. Each book has a code c of 3, 4, 5 or more capitals letters.
# The 1st letter of a code is the capital letter of the book category.
# In the bookseller's stocklist each code c is followed by a space and by a positive integer n (int n >= 0) which indicates the quantity of books of this code in stock.
# For example an extract of one of the stocklists could be:
# L = {"ABART 20", "CDXEF 50", "BKWRK 25", "BTSQZ 89", "DRTYM 60"}.
# or
# L = ["ABART 20", "CDXEF 50", "BKWRK 25", "BTSQZ 89", "DRTYM 60"] or ....
# You will be given a stocklist (e.g. : L) and a list of categories in capital letters e.g :
#   M = {"A", "B", "C", "W"}
# or
#   M = ["A", "B", "C", "W"] or ...
# and your task is to find all the books of L with codes belonging to each category of M and to sum their quantity according to each category.
# For the lists L and M of example you have to return the string (in Haskell/Clojure/Racket a list of pairs):
#   (A : 20) - (B : 114) - (C : 50) - (W : 0)
# where A, B, C, W are the categories, 20 is the sum of the unique book of category A, 114 the sum corresponding to "BKWRK" and "BTSQZ",
# 50 corresponding to "CDXEF" and 0 to category 'W' since there are no code beginning with W.
# If L or M are empty return string is "" (Clojure and Racket should return an empty array/list instead).
# Note:
# In the result codes and their values are in the same order as in M.
# example
# b = ["BBAR 150", "CDXE 515", "BKWR 250", "BTSQ 890", "DRTY 600"]
# c = ["A", "B", "C", "D"]
# res = "(A : 0) - (B : 1290) - (C : 515) - (D : 600)"
# Test.assert_equals(stockList(b, c), res)

# My_answer
def stockList(listOfArt, listOfCat)
  listOfArt = split_listOfArt(listOfArt)

  category_and_quantity = {}

  listOfCat.each do |cat|
    category_and_quantity[cat] = 0
    listOfArt.each do |art|
      if art[0][0] == cat
        category_and_quantity[cat] = add_quantity(category_and_quantity[cat], art[1].to_i)
      end
    end
  end

  category_and_quantity.map { |key_value| molding_result(key_value) }.join(" - ")
end

def split_listOfArt(listOfArt)
  listOfArt.map { |art| art.split(" ") }
end

def add_quantity(current_amount, increase)
  current_amount + increase
end

def molding_result(key_value)
  key_value.join(" : ").insert(0, "(").insert(-1, ")")
end

# Best_answer
def stockList(stock_list, categories)
  return "" if stock_list.empty? || categories.empty?

  quantities = Hash.new(0)
  stock_list.each_with_object(quantities) do |item, quantities|
    code, quantity = item.split(" ")
    quantities[code[0]] += quantity.to_i
  end

  categories.map { |category| "(#{category} : #{quantities[category]})" }.join(" - ")
end

# No.102
# Write a function that takes a positive integer and returns the next smaller positive integer containing the same digits.
# For example:
# next_smaller(21) == 12
# next_smaller(531) == 513
# next_smaller(2071) == 2017
# Return -1 (for Haskell: return Nothing, for Rust: return None), when there is no smaller number that contains the same digits.
# Also return -1 when the next smaller number with the same digits would require the leading digit to be zero.
# next_smaller(9) == -1
# next_smaller(135) == -1
# next_smaller(1027) == -1  # 0721 is out since we don't write numbers with leading zeros
# some tests will include very large numbers.
# test data only employs positive integers.
# The function you write for this challenge is the inverse of this kata: "Next bigger number with the same digits."

# My_answer(false)
def next_smaller(n)
  result = n.digits.permutation.select { |p| p.join.to_i < n && p.first != 0 }
  result.empty? ? -1 : result.last.join.to_i
end

# Best_answer
def next_smaller(n)
  digits = n.to_s.chars.map { |d| d.to_i }
  return -1 if n.to_s.size == 1 || digits.sort.join == n.to_s
  digits.reverse!
  digits.each_with_index do |d, i|
    if digits[i + 1] && digits[i + 1] > digits[i]
      max = digits[0...i + 1].select { |a| a < digits[i + 1] }.sort.reverse.shift
      arr = digits[0..i + 1].sort
      arr.delete_at(arr.index(max))
      arr << max
      arr += digits[i + 2..-1]
      smaller = arr.reverse.join.to_i
      return -1 if smaller.to_s.size < digits.size
      return smaller
    end
  end
end

# No.103
# Description:
# Given two strings s1 and s2, we want to visualize how different the two strings are.
# We will only take into account the lowercase letters (a to z). First let us count the frequency of each lowercase letters in s1 and s2.
# s1 = "A aaaa bb c"
# s2 = "& aaa bbb c d"
# s1 has 4 'a', 2 'b', 1 'c'
# s2 has 3 'a', 3 'b', 1 'c', 1 'd'
# So the maximum for 'a' in s1 and s2 is 4 from s1; the maximum for 'b' is 3 from s2.
# In the following we will not consider letters when the maximum of their occurrences is less than or equal to 1.
# We can resume the differences between s1 and s2 in the following string: "1:aaaa/2:bbb" where 1 in 1:aaaa stands for string s1 and aaaa because the maximum for a is 4.
# In the same manner 2:bbb stands for string s2 and bbb because the maximum for b is 3.
# The task is to produce a string in which each lowercase letters of s1 or s2 appears as many times as its maximum if this maximum is strictly greater than 1;
# these letters will be prefixed by the number of the string where they appear with their maximum value and :.
# If the maximum is in s1 as well as in s2 the prefix is =:.
# In the result, substrings (a substring is for example 2:nnnnn or 1:hhh; it contains the prefix) will be in decreasing order of their length
# and when they have the same length sorted in ascending lexicographic order (letters and digits - more precisely sorted by codepoint);
# the different groups will be separated by '/'. See examples and "Example Tests".
# Hopefully other examples can make this clearer.
# s1 = "my&friend&Paul has heavy hats! &"
# s2 = "my friend John has many many friends &"
# mix(s1, s2) --> "2:nnnnn/1:aaaa/1:hhh/2:mmm/2:yyy/2:dd/2:ff/2:ii/2:rr/=:ee/=:ss"
# s1 = "mmmmm m nnnnn y&friend&Paul has heavy hats! &"
# s2 = "my frie n d Joh n has ma n y ma n y frie n ds n&"
# mix(s1, s2) --> "1:mmmmmm/=:nnnnnn/1:aaaa/1:hhh/2:yyy/2:dd/2:ff/2:ii/2:rr/=:ee/=:ss"
# s1="Are the kids at home? aaaaa fffff"
# s2="Yes they are here! aaaaa fffff"
# mix(s1, s2) --> "=:aaaaaa/2:eeeee/=:fffff/1:tt/2:rr/=:hh"

# Best_answer
def mix(s1, s2)
  # s1とs2から2文字以上含まれる文字を抽出
  selection = ("a".."z").to_a.select { |letter| s1.count(letter) > 1 || s2.count(letter) > 1 }
  # s1とs2の出現回数を比較し、プレフィックスを付与した配列を作成する
  selection.map! do |selection|
    if s1.count(selection) > s2.count(selection)
      "1:#{selection * s1.count(selection)}"
    elsif s1.count(selection) < s2.count(selection)
      "2:#{selection * s2.count(selection)}"
    else
      "=:#{selection * s1.count(selection)}"
    end
  end
  # 出現回数（文字列の長さ）、1or2、アルファベット順でソートする
  selection.sort_by { |x| [-x.size, x[0], x[-1]] }.join("/")
end

# No.104
# Take an array and remove every second element out of that array. Always keep the first element and start removing with the next element.
# Example:
# my_arr = ['Keep', 'Remove', 'Keep', 'Remove', 'Keep', ...]
# None of the arrays will be empty, so you don't have to worry about that!

# My_answer
def remove_every_other(arr)
  arr.delete_if.with_index { |_, i| i.odd? }
end

# Best_answer
def remove_every_other(arr)
  arr.select.with_index { |_, idx| idx.even? }
end
