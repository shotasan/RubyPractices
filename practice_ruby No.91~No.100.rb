# No.91
# Description:
# Given an array of words and a target compound word, your objective is to find the two words which combine into the target word, returning both words in the order they appear in the array, and their respective indices in the order they combine to form the target word. Words in the array you are given may repeat, but there will only be one unique pair that makes the target compound word. If there is no match found, return null/nil/None.

# Note: Some arrays will be very long and may include duplicates, so keep an eye on efficiency.

# Examples:

# fn(['super','bow','bowl','tar','get','book','let'], "superbowl")      =>   ['super','bowl',   [0,2]]
# fn(['bow','crystal','organic','ally','rain','line'], "crystalline")   =>   ['crystal','line', [1,5]]
# fn(['bow','crystal','organic','ally','rain','line'], "rainbow")       =>   ['bow','rain',     [4,0]]
# fn(['bow','crystal','organic','ally','rain','line'], "organically")   =>   ['organic','ally', [2,3]]
# fn(['top','main','tree','ally','fin','line'], "mainline")             =>   ['main','line',    [1,5]]
# fn(['top','main','tree','ally','fin','line'], "treetop")              =>   ['top','tree',     [2,0]]

# My_answer(false)
def compound_match(fragments, target)
  match_set = fragments.map.with_index{|word, idx| [target.split(word), idx]}.select{|item| item[0].include?("")}
  match_set = match_set.select{ |item| fragments.index(item.first&.last) != nil}
  index1 = match_set.first&.last
  index2 = fragments.index(match_set&.first&.first&.last) || nil
  return nil if index2.nil?

  if fragments[index1] + fragments[index2] == target
    if index1 < index2
      return [fragments[index1], fragments[index2], [index1, index2]]
    else
      return [fragments[index2], fragments[index1], [index1, index2]]
    end
  else
    if index1 < index2
      return [fragments[index1], fragments[index2], [index2, index1]]
    else
      return [fragments[index2], fragments[index1], [index2, index1]]
    end
  end
end

# Best_answer
def compound_match(fragments, target)
  # fragmentsの重複なしの全組み合わせを取得し、reverseを使用して両パターンを検討
  # targetと一致する組み合わせを取得する
  res = fragments.uniq.combination(2).select{ |i| [i.join,i.reverse.join].include?(target) }.flatten
  # 一致する組み合わせがなければnilを返す
  return nil if res.empty?
  # 各単語のインデックスを取得する
  l = res.map{|i| fragments.index(i)}
  m = res.join == target ? l : l.reverse
  res += [m]
end


# No.92
# Description:
# In this example you have to validate if a user input string is alphanumeric.
# The given string is not nil/null/NULL/None, so you don't have to check that.
# The string has the following conditions to be alphanumeric:
# At least one character ("" is not valid)
# Allowed characters are uppercase / lowercase latin letters and digits from 0 to 9
# No whitespaces / underscore

# My_answer
def alphanumeric?(string)
  string.match /\A[a-zA-Z\d]+\z/
end

# Best_answer
def alphanumeric?(string)
  string =~ /\A[A-z\d]+\z/
end