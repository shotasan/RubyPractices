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