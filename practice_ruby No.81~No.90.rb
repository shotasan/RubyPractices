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
