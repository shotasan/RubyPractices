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


# No.22
# We need a function that can receive a number ann may output in the following order:
# the amount of multiples
# the maximum multiple
# 362 ----> 3, 6, 2, 36, 63, 62, 26, 32, 23, 236, 263, 326, 362, 623, 632
# But only:3, 6, 36, 63 are multiple of three.
# Let's see a case the number has a the digit 0 and repeated digits:
# 6063 ----> 0, 3, 6, 30, 36, 60, 63, 66, 306, 360, 366, 603, 606, 630, 636, 660, 663, 3066, 3606, 3660, 6036, 6063, 6306, 6360, 6603, 6630
# In this case the multiples of three will be all except 0
# 6063 ----> 3, 6, 30, 36, 60, 63, 66, 306, 360, 366, 603, 606, 630, 636, 660, 663, 3066, 3606, 3660, 6036, 6063, 6306, 6360, 6603, 6630
# The cases above for the function:
# find_mult_3(362) == [4, 63]
# find_mult_3(6063) == [25, 6630]

# My_answer(false)
def find_mult_3(num)
    nums = num.digits
    i = 1
    array = []
    until i > nums.count
      a = nums.permutation(i).to_a.map{ |num| num.join.to_i }
      b = a.select{|num| num != 0 && num % 3 == 0}
      array << b.uniq
      i += 1
    end
    result = array.flatten.uniq
    return [result.count, result.max]
end

# Best_answer
def find_mult_3(num)
  nums = num.to_s.chars
  all = (0..num.size).inject(Set.new){|sum,i| sum.merge nums.permutation(i+1).map{|k|k.join.to_i} }
  div3 = all.select{|l| (l%3) == 0 and !l.zero?}
  [div3.size, div3.max]
end

# No.23
# Your goal in this kata is to implement a difference function, which subtracts one list from another and returns the result.
# It should remove all values from list a, which are present in list b.
# array_diff([1,2],[1]) == [2]
# If a value is present in b, all of its occurrences must be removed from the other:
# array_diff([1,2],[1]) == [2]

# My_answer
def array_diff(a, b)
  a - b
end

# Best_answer
def array_diff(a, b)
  a - b
end


# No.24
# You are going to be given an array of integers.
# Your job is to take that array and find an index N where the sum of the integers to the left of N is equal to the sum of the integers to the right of N.
# If there is no index that would make this happen, return -1.

# My_answer
def find_even_index(arr)
  left_side = 0
  right_side = arr.reduce(:+)
  
  arr.each_with_index do |e, ind|
    right_side -= e
    return ind if left_side == right_side
    left_side += e
  end
  
  -1
end

# Best_answer
def find_even_index(arr)
  left_sum = 0
  right_sum = arr.reduce(:+)
  
  arr.each_with_index do |e, ind|
    right_sum -= e
    
    return ind if left_sum == right_sum

    left_sum += e
  end
  
  -1  
end


# No.25
# Requirement
# return a string where:
# 1) the first and last characters remain in original place for each word
# 2) characters between the first and last characters must be sorted alphabetically
# 3) punctuation should remain at the same place as it started, for example: shan't -> sahn't

# Assumptions
# 1) words are seperated by single spaces
# 2) only spaces separate words, special characters do not, for example: tik-tak -> tai-ktk
# 3) special characters do not take the position of the non special characters, for example: -dcba -> -dbca
# 4) for this kata puctuation is limited to 4 characters: hyphen(-), apostrophe('), comma(,) and period(.) 
# 5) ignore capitalisation

# My_answer(false)
def scramble_words(words)
  first_word = words[0]
  last_word = words[-1]
  alphabetically = words[1, (words.size - 2)].chars.sort
  alphabetically.unshift(first_word).push(last_word).join
end

Best_answer
# 文章の場合は空欄ごとの単語に区切ってmapで回す
def scramble_words(words)
  byebug
  words.split(' ').map { |word| scramble(word) }.join(' ')
end

# 真ん中の文字列を並び替えるメソッド
def scramble(word)
  # 記号込みの文字列
  chars = word.chars
  # 文字列だけを取り出す
  letters = chars.select { |char| letter?(char) }
  # ソート後の文字列が入る
  scrambled_letters = scramble_letters(letters.join).chars
  # 記号を入れ直した文字列を返す
  # 最初の文字列を1文字ずつ文字列かどうかチェックする
  # 文字列であれば記号を除いてソートした文字列の配列の先頭を取り出す
  # 記号であればそのまま記号を配列に入れる
  # 当初の文字列の文字数とソート後の文字列の文字数は記号分を除けば一致する
  chars.map do |char|
    letter?(char) ? scrambled_letters.shift : char
  end
    .join
end

# 記号を除いた文字列がwordに渡される
def scramble_letters(word)
  return word if word.length <= 2
  
  # 文字列の先頭と最後以外をsortする
  word[0] + word[1...-1].chars.sort.join + word[-1]
end

# 引数が文字リテラルかチェックするメソッド
def letter?(char)
  char.match? /[a-z]/
end