# No.21
# You will be given an array of values.
# For simplicity sake you can assume that all the numbers will be non-negative integers.
# The goal is to create a class that handles finding all the values in the array that are within a given range of each other.
# Return the final values in ascending order.
# GroupByDifference.new([5, 32, 5, 1, 31, 70, 30, 8]).find(3) #=> [5,5,8,30,31,32]

# My_answer
class GroupByDifference
  def initialize(numbers)
    @numbers = numbers.sort
  end
  
  def find(difference)
    final_values = @numbers.each_cons(2).to_a.select{ |first, second| (second - first) <= difference }.flatten.uniq
    @numbers.select { |i| final_values.include?(i) }
  end
end

# Best_answer
class GroupByDifference
  def initialize(numbers)
    @numbers = numbers.sort
  end
  
  def find(difference)
    @numbers.select.with_index {|x, i|
       (i > 0 and @numbers[i-1] + difference >= x) or  (i < @numbers.length - 1 and @numbers[i+1] <= difference + x)
    }
  end
end