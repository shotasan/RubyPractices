# No.51
# You get an array of arrays.
# If you sort the arrays by their length, you will see, that their length-values are consecutive.
# But one array is missing!
# You have to write a method, that return the length of the missing array.
# Example:
# [[1, 2], [4, 5, 1, 1], [1], [5, 6, 7, 8, 9]] --> 3
# If the array of arrays is null/nil or empty, the method should return 0.
# When an array in the array is null or empty, the method should return 0 too!
# There will always be a missing element and its length will be always between the given arrays. 

# My_answer
def getLengthOfMissingArray(array_of_arrays)
  return 0 if array_of_arrays.nil? || array_of_arrays.empty? || array_of_arrays.any?{ |array| array == [] || array == nil }

  array_of_length = array_of_arrays.map(&:length)
  ([*array_of_length.min..array_of_length.max] - array_of_length).first
end

# Best_answer
def getLengthOfMissingArray(array_of_arrays)
  return 0 if array_of_arrays.nil?
  return 0 if array_of_arrays.empty?
  return 0 if array_of_arrays.any?{|arr| arr.nil?}
  return 0 if array_of_arrays.any?{|arr| arr.empty?}

  sorted = array_of_arrays.sort_by{|array| array.length}
  offset_idx = sorted.first.length
  sorted.each_with_index do |arr,idx|
    if arr.length != idx + offset_idx
      return sorted.index(arr) + offset_idx
    end
  end
end


# No.52
# Complete the solution so that the function will break up camel casing, using a space between words.
# Example
# solution('camelCasing') # => should return 'camel Casing'

# My_answer
def solution(string)
  string.gsub(/(?=[A-Z])/, ' ')
end

# Best_answer
def solution(string)
  string.gsub /([A-Z])/, ' \1'
end