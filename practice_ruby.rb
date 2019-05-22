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


# No.4
# Given a string, detect whether or not it is a pangram.
# Return True if it is, False if not.
# Ignore numbers and punctuation.

# My_answer
def panagram?(string)
  string.chars.map(&:downcase).uniq.grep(/[A-Za-z]/).sort.eql?([*"a".."z"])
end

# Best_answer
def panagram?(string)
  ('a'..'z').all? { |x| string.downcase.include? (x) } 
end


# No.5
# You must create a digital root function.
# A digital root is the recursive sum of all the digits in a number. Given n, take the sum of the digits of n.
# If that value has more than one digit, continue reducing in this way until a single-digit number is produced.
# This is only applicable to the natural numbers.

# digital_root(942)
# => 9 + 4 + 2
# => 15 ...
# => 1 + 5
# => 6

# digital_root(132189)
# => 1 + 3 + 2 + 1 + 8 + 9
# => 24 ...
# => 2 + 4
# => 6

# My_answer
def digital_root(n)
  n < 10 ? n : digital_root(n.digits.inject(:+))
end

# Best_answer
def digital_root(n)
  n < 10 ? n : digital_root(n / 10 + n % 10)
end


# No.6
# Write a function that takes in a string of one or more words, and returns the same string,
# but with all five or more letter words reversed (Just like the name of this Kata).
# Strings passed in will consist of only letters and spaces. Spaces will be included only when more than one word is present.

# spinWords( "Hey fellow warriors" ) => returns "Hey wollef sroirraw" 

# My_answer
def spinWords(string)
  string.split.map{ |str| str.length >= 5 ? str.reverse : str }.join(" ")
end

# Best_answer
def spinWords(string)
  string.gsub(/\w{5,}/, &:reverse)
end


# No.7
# Your task is to sort a given string. Each word in the string will contain a single number.
# This number is the position the word should have in the result.
# Numbers can be from 1 to 9. So 1 will be the first word (not 0).
# If the input string is empty, return an empty string.
# The words in the input String will only contain valid consecutive numbers.

# "is2 Thi1s T4est 3a"  -->  "Thi1s is2 3a T4est"

# My_answer
def order(words)
  numbers = words.delete("^1-9").split("")
  numbers.zip(words.split).sort.map(&:last).join(" ")
end

# Best_answer
def order(words)
  words.split.sort_by { |w| w.chars.min } .join(" ")
end


# No.8
# The input consists of a single non-empty string, consisting only of uppercase English letters, the string's length doesn't exceed 200 characters
# Return the words of the initial song that Polycarpus used to make a dubsteb remix. Separate the words with a space.

# song_decoder("WUBWEWUBAREWUBWUBTHEWUBCHAMPIONSWUBMYWUBFRIENDWUB")
  #  =>  WE ARE THE CHAMPIONS MY FRIEND

# My_answer
def song_decoder(song)
  song.gsub(/WUB/, " ").split.join(" ")
end

# Best_answer
def song_decoder(song)
  song.gsub(/(WUB)+/, ' ').strip
end