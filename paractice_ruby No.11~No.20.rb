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


# No.12
# Implement the function unique_in_order which takes as argument a sequence and returns a list of items without any elements with the same value next to each other and preserving the original order of elements.
# unique_in_order('AAAABBBCCDAABBB') == ['A', 'B', 'C', 'D', 'A', 'B']
# unique_in_order('ABBCcAD')         == ['A', 'B', 'C', 'c', 'A', 'D']
# unique_in_order([1,2,2,3,3])       == [1,2,3]

# My_answer
def unique_in_order(iterable)
  if iterable.class == Array
    return iterable.uniq
  else
    result = []
    iterable.chars.each do |chr|
      result << chr if result.last != chr
    end
    result
  end
end

# Best_answer
def unique_in_order(iterable)
  (iterable.is_a?(String) ? iterable.chars : iterable).chunk { |x| x }.map(&:first)
end


# No.13
# This time we want to write calculations using functions and get the results. Let's have a look at some examples:
# seven(times(five)) # must return 35
# four(plus(nine)) # must return 13
# eight(minus(three)) # must return 5
# six(divided_by(two)) # must return 3

# Best_answer (source_reading)
class Operation
  # num => 5
  # op => :*
  def initialize(num, op)
    @num = num
    @op = op
  end
  
  # 最終結果を返すメソッド
  def perform(num)
    # sendメソッドは第一引数をselfのメソッドを指定する
    # 第二引数を引数として第一引数のメソッドを実行する
    # numの@opメソッドを@num.to_fを引数として実行する
    # to_fメソッドは浮動小数点数 Float に変換    
    # num => 7
    # @op => :*
    # @num => 5
    # @num.to_f => 0.0
    # ここで7*5が実行される
    num.send(@op, @num.to_f)
  end
end

NUMBER_WORDS = %w(zero one two three four five six seven eight nine)
OPERATION_WORDS = {
  :"+" => "plus",
  :"-" => "minus",
  :"*" => "times",
  :"/" => "divided_by"
}

# zeroからnineまで全てにインデックスを付番しwordをメソッドとする
NUMBER_WORDS.each_with_index do |word, num|
  # define_methodは引数(word.to_sym)をインスタンスメソッドとして定義する
  # ブロックを与えた場合、定義したメソッドの実行時にブロックが レシーバクラスのインスタンスの上で BasicObject#instance_eval されます。

  # word.to_sym(例 :seven)がインスタンスメソッドになる
  # wordを入力するとインデックスのnumが帰るメソッドを定義する
  # operationにはOperationクラスのインスタンスが入る
  # operation => @num=5, @op= :*
  # Operationクラスのインスタンスメソッドperformを使用
  # 引数のnumにはeach_with_indexで設定したインデックス番号が入る(例 sevenなら7)
  # ブロックにブロック引数を加えるとブロック引数がメソッドの引数になる
  # sevenだけだと７を返す。seven(引数)ならoperation.perform(num)を実行する
  define_method word.to_sym do |operation = nil|
    # operation.perform(num) => 35.0
    operation ? operation.perform(num) : num
  end
end

# 計算記号の設定
# wordのハッシュをメソッドとして定義し、実行される際にブロック内のOperation.newが実行される
# どちらも必ず実行される
# OPERATION_WORDS全てをmethodに記号を入れ、wordに言葉を入れる(plus,minus等)
OPERATION_WORDS.each do |method, word|
  # word.to_sym => :times
  # num => 5
  define_method word.to_sym do |num|
    # newの引数
    # num => 5
    # method => :*
    Operation.new(num, method)
  end
end

# sevenメソッドが呼ばれる
# 引数のtimesが実行される
# timesの引数fiveが実行される
# timesメソッドが呼ばれた際にブロック内のOperation.newが実行される(num => 5, method => times)
# Operationクラスのインスタンス変数ににfiveとmethodが代入される
# sevenメソッドのブロック引数のoperationに上記のインスタンスが引数として実行される
# sevenメソッドのブロックが実行されOperationクラスのインスタンスメソッドperfomが実行される
# sendメソッドによりseven,method,fiveを使用して式が実行され結果が返される
seven(times(five()))