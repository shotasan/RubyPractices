# No.71
# You need to write regex that will validate a password to make sure it meets the following criteria:
# At least six characters long
# contains a lowercase letter
# contains an uppercase letter
# contains a number
# Valid passwords will only be alphanumeric characters.
# Example:
# (regex=~'fjd3IR9')==0, true
# (regex=~'ghdfj32')==0, false

# My_answer
regex = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{6,}+\z/

# Best_answer
regex = /(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])^[a-zA-Z0-9]{6,}$/


# No.72
# Write a function named first_non_repeating_letter that takes a string input,
# and returns the first character that is not repeated anywhere in the string.
# For example, if given the input 'stress', the function should return 't',
# since the letter t only occurs once in the string, and occurs first in the string.
# As an added challenge, upper- and lowercase letters are considered the same character,
# but the function should return the correct case for the initial letter. For example, the input 'sTreSS' should return 'T'.
# If a string contains all repeating characters, it should return an empty string ("") or None -- see sample tests.
# first_non_repeating_letter('a'), 'a'
# first_non_repeating_letter('stress'), 't'
# first_non_repeating_letter('moonmen'), 'e'

# My_answer(false)
def  first_non_repeating_letter(s)
  return "" if s.empty?
  return s if s.length == 1
  table = Hash.new(0)
  s.downcase.scan(/./){ |m| table[m] += 1}
  if table.values.uniq.length == 1
    return ""
  else
    min_word = table.key(table.values.min)
    s.scan(/#{min_word}/i)[0]
  end
end

# Best_answer
def  first_non_repeating_letter(s) 
  s.chars.find {|i| s.downcase.count(i)==1 || s.upcase.count(i)==1} || ""
end