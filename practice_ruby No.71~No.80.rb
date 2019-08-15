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


# No.73
# I'm sure, you know Google's "Did you mean ...?", when you entered a search term and mistyped a word. In this kata we want to implement something similar.
# You'll get an entered term (lowercase string) and an array of known words (also lowercase strings).
# Your task is to find out, which word from the dictionary is most similar to the entered one.
# The similarity is described by the minimum number of letters you have to add, remove or replace in order to get from the entered word to one of the dictionary.
# The lower the number of required changes, the higher the similarity between each two words.
# Same words are obviously the most similar ones. A word that needs one letter to be changed is more similar to another word that needs 2 (or more) letters to be changed.
# E.g. the mistyped term berr is more similar to beer (1 letter to be replaced) than to barrel (3 letters to be changed in total).
# Extend the dictionary in a way, that it is able to return you the most similar word from the list of known words.
# Code Examples:
# fruits = new Dictionary(['cherry', 'pineapple', 'melon', 'strawberry', 'raspberry']);
# fruits.findMostSimilar('strawbery'); // must return "strawberry"
# fruits.findMostSimilar('berry'); // must return "cherry"
# things = new Dictionary(['stars', 'mars', 'wars', 'codec', 'codewars']);
# things.findMostSimilar('coddwars'); // must return "codewars"
# languages = new Dictionary(['javascript', 'java', 'ruby', 'php', 'python', 'coffeescript']);
# languages.findMostSimilar('heaven'); // must return "java"
# languages.findMostSimilar('javascript'); // must return "javascript" (same words are obviously the most similar ones)
# I know, many of you would disagree that java is more similar to heaven than all the other ones, but in this kata it is ;)
# Additional notes:
# there is always exactly one possible solution

# Best_answer
# レーベンシュタイン距離
class Dictionary
  def initialize(words)
    @words=words
  end
  def find_most_similar(term)
    @words.min_by do |word|
      levenshtein_distance word, term
    end
  end
  
  private
  
  def levenshtein_distance(s, t)
    byebug
    # 文字数のカウント
    m = s.length
    n = t.length
    return m if n == 0
    return n if m == 0
    # m = 6, n = 9の場合　10個の要素をもつ配列が、7個作られる
    d = Array.new(m+1) {Array.new(n+1)}
  
    # dの7つの配列の先頭の要素に0から6が代入される
    (0..m).each {|i| d[i][0] = i}
    # dの7つの配列の内、最初の配列に2番目の要素から1から9が代入される。[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    (0..n).each {|j| d[0][j] = j}
    (1..n).each do |j|
      (1..m).each do |i|

                  # i = 1の場合 j = 1の場合　sの1文字目とtの1文字目が一致するか
                  #削除、挿入、置換によりコストを計算し、最小値を返す
        d[i][j] = if s[i-1] == t[j-1]  # adjust index into string
                    d[i-1][j-1]       # no operation required
                  else
                    [ d[i-1][j]+1,    # deletion
                      d[i][j-1]+1,    # insertion
                      d[i-1][j-1]+1,  # substitution
                    ].min
                  end
      end
    end
    d[m][n]
  end
end


# No.74
# Define a method that accepts 2 strings as parameters.
# The method returns the first string sorted by the second.
# sort_string('foos', 'of')
# # => 'oofs'
# sort_string('string', 'gnirts')
# # => 'gnirts'
# sort_string('banana', 'abn')
# # => 'aaabnn'
# To elaborate, the second string defines the ordering.
# It is possible that in the second string characters repeat, so you should remove repeating characters, leaving only the first occurrence.
# Any character in the first string that does not appear in the second string should be sorted to the end of the result in original order.

# My_answer
def sort_string(str, ordering)
  order = ordering.chars.uniq
  str = str.chars
  result = []

  order.map do |ord|
    str.map do |char|
      if char == ord
        result << char
      end
    end 
  end

  (result + (str - result)).join
end

# Best_answer
def sort_string(str, ordering)
  # orderingに無い文字はordering.sizeの値で判定される
  str.chars.sort_by { |item| ordering.index(item) || ordering.size }.join
end


# No.75
# For this exercise you will be strengthening your page-fu mastery.
# You will complete the PaginationHelper class, which is a utility class helpful for querying paging information related to an array.
# The class is designed to take in an array of values and an integer indicating how many items will be allowed per each page.
# The types of values contained within the collection/array are not relevant.
# The following are some examples of how this class is used:

# helper = PaginationHelper.new(['a','b','c','d','e','f'], 4)
# helper.page_count # should == 2
# helper.item_count # should == 6
# helper.page_item_count(0)  # should == 4
# helper.page_item_count(1) # last page - should == 2
# helper.page_item_count(2) # should == -1 since the page is invalid
# # page_ndex takes an item index and returns the page that it belongs on
# helper.page_index(5) # should == 1 (zero based index)
# helper.page_index(2) # should == 0
# helper.page_index(20) # should == -1
# helper.page_index(-10) # should == -1 because negative indexes are invalid

# My_answer
class PaginationHelper

  # The constructor takes in an array of items and a integer indicating how many
  # items fit within a single page
  def initialize(collection, items_per_page)
    @collection = collection
    @items_per_page = items_per_page
  end
  
  # returns the number of items within the entire collection
  def item_count
    @collection.length
  end
	
  # returns the number of pages
  def page_count
    @collection.each_slice(@items_per_page).to_a.length
  end
	
  # returns the number of items on the current page. page_index is zero based.
  # this method should return -1 for page_index values that are out of range
  def page_item_count(page_index)
    return -1 if page_count <= page_index

    @collection.each_slice(@items_per_page).to_a[page_index].length
  end
	
  # determines what page an item is on. Zero based indexes.
  # this method should return -1 for item_index values that are out of range
  def page_index(item_index) 
    return -1 if item_index + 1 > item_count || item_index < 0
    item_index / @items_per_page
  end
end

# Best_answer
class PaginationHelper
  attr_reader :collection, :per_page

  def initialize(collection, per_page)
    @collection = collection
    @per_page = per_page
  end

  def item_count
    @collection.size
  end
  
  def page_count
    (item_count.to_f / per_page).ceil
  end
  
  def page_item_count(index)
    i = collection[index * per_page...index * per_page + per_page]
    i ? i.size : -1
  end
  
  def page_index(index)
   return -1 unless (0...item_count).include? index
   page = index / per_page
  end
end