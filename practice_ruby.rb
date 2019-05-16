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