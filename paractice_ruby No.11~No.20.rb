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