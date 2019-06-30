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