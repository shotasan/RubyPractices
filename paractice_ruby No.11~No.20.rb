# No.11
# You are given an array strarr of strings and an integer k.
# Your task is to return the first longest string consisting of k consecutive strings taken in the array.
# n being the length of the string array, if n = 0 or k > n or k <= 0 return "".

# longest_consec(["zone", "abigail", "theta", "form", "libe", "zas", "theta", "abigail"], 2) --> "abigailtheta"

# My_answer
def longest_consec(strarr, k)
  if strarr.count > k && k > 0
    strarr.each_cons(k).to_a.map(&:join).max{ |a,b| a.length <=> b.length }
  end
end

# Best_answer
def longest_consec(strarr, k)
  return "" unless k.between?(1, strarr.length)
  strarr.each_cons(k).map(&:join).max_by(&:length) || ""
end


# No.12
# Implement the function unique_in_order which takes as argument a sequence and returns a list of items without any elements with the same value next to each other and preserving the original order of elements.
# unique_in_order('AAAABBBCCDAABBB') == ['A', 'B', 'C', 'D', 'A', 'B']
# unique_in_order('ABBCcAD')         == ['A', 'B', 'C', 'c', 'A', 'D']
# unique_in_order([1,2,2,3,3])       == [1,2,3]

# My_answer
def unique_in_order(iterable)
  if iterable.class == Array
    return iterable.uniq
  else
    result = []
    iterable.chars.each do |chr|
      result << chr if result.last != chr
    end
    result
  end
end

# Best_answer
def unique_in_order(iterable)
  (iterable.is_a?(String) ? iterable.chars : iterable).chunk { |x| x }.map(&:first)
end