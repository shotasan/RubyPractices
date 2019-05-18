# NO.1
# To do this, you must first count the 'mini-wins' on your ticket.
# Each sub array has both a string and a number within it.
# If the character code of any of the characters in the string matches the number, you get a mini win. 
# Note you can only have one mini win per sub array.
# Once you have counted all of your mini wins, compare that number to the other input provided (win).
# If your total is more than or equal to (win), return 'Winner!'. Else return

# Test.assert_equals(bingo([['ABC', 65], ['HGR', 74], ['BYHT', 74]], 2), 'Loser!')
# Test.assert_equals(bingo([['ABC', 65], ['HGR', 74], ['BYHT', 74]], 1), 'Winner!')
# Test.assert_equals(bingo([['HGTYRE', 74], ['BE', 66], ['JKTY', 74]], 3), 'Loser!')

# My_answer
def bingo(ticket,win)
    win_check = ticket.map do |tic|
        tic.first.chars.map do |char|
            char.ord == tic.last ? true : false
        end
    end
    win_count = 0
    win_check.each do |i|
        win_count += 1 if i.include?(true)
    end
    win_count >= win ? "Winner!" : "Loser!"
end

# Best_answer
def bingo(ticket, win)
  ticket.count { |string, code| string.include?(code.chr) } >= win ? 'Winner!' : 'Loser!'
end


# No.2
# Write a function, persistence, that takes in a positive parameter num and returns its multiplicative persistence,
# which is the number of times you must multiply the digits in num until you reach a single digit.

# persistence(39) # returns 3, because 3*9=27, 2*7=14, 1*4=4
#                  # and 4 has only one digit
# persistence(999) # returns 4, because 9*9*9=729, 7*2*9=126,
#                   # 1*2*6=12, and finally 1*2=2
# persistence(4) # returns 0, because 4 is already a one-digit number

# My_answer
def persistence(n)
  count = 0
  until n.to_s.split("")[1] == nil
    n.to_s.split("").inject do |result, num|
      n = result.to_i * num.to_i
    end
    count += 1
  end
  return count
end

# Best_answer
def persistence(n)
  n < 10 ? 0 : 1 + persistence(n.to_s.chars.map(&:to_i).reduce(:*))
end


# No.3
# You are given an array (which will have a length of at least 3, but could be very large) containing integers.
# The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N.
# Wdrite a method that takes the array as an argument and returns this "outlier" N.

# [2, 4, 0, 100, 4, 11, 2602, 36]
# Should return: 11 (the only odd number)

# [160, 3, 1719, 19, 11, 13, -21]
# Should return: 160 (the only even number

# My_answer
def find_outlier(integers)
  if integers.select(&:even?).count > 1
    integers.select(&:odd?).first
  else
    integers.select(&:even?).first
  end
end

# Best_answer
def find_outlier(integers)
  integers.partition(&:odd?).find(&:one?).first
end