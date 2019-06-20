# No.31
# The GenericEntity class should allow any hash to be passed to its initializer which then creates instance variables and matching attribute readers for each key/value pair in the hash:
# box = GenericEntity.new(:shape => "square", :material => "cardboard")
# #box now has instance variables @shape and @material and attribute readers for both
# box.material #=> "cardboard"

# Best_answer
class GenericEntity
  def initialize(attrs = {})
    # 引数のハッシュを一つずつ取り出す
    # instance_variable_set("@#{attr}", value)でキー名のインスタンス変数を作成し、値を設定する
    # define_singleton_method(attr) { instance_variable_get("@#{attr}") }でキー名のメソッドを作成し、インスタンス変数にアクセスできるようにする
    attrs.each do |attr, value|
      # [メソッド]
      # define_singleton_method(symbol) { ... } -> Symbol
      # self に特異メソッド name を定義します。
      
      # instance_variable_get(var) -> object | nil
      # オブジェクトのインスタンス変数の値を取得して返します。
      # インスタンス変数が定義されていなければ nil を返します。

      # [内容]
      # define_singleton_method(attr)でキー名のメソッドを作成する
      # メソッドの内容はインスタンス変数を取得するだけ
      # instance_variable_get("@#{attr}")でインスタンス変数　@キー名でインスタンス変数を取得できるようになる
      define_singleton_method(attr) { instance_variable_get("@#{attr}") }
      # [メソッド]
      # instance_variable_set(var, value) -> object
      # オブジェクトのインスタンス変数 var に値 value を設定します。
      # インスタンス変数が定義されていなければ新たに定義されます。

      # [内容]
      # インスタンス変数を設定する
      # インスタンス変数@キー名にvalueを設定する
      instance_variable_set("@#{attr}", value)
    end
  end
end
