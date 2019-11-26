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
