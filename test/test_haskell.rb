require 'minitest_helper'

class TestHaskell < MiniTest::Unit::TestCase
  def test_main
    assert_equal_execute('3') {"
      add :: Integer -> Integer -> Integer
      add x y = x + y
      result = add 1 2
    "}

    assert_equal_execute('[3.1415927,4.0]') {"
      data Point = Pt Float Float deriving (Show)
      data Shape = Circle Point Float | Rectangle Point Point deriving (Show)
      surface :: Shape -> Float
      surface (Circle _ r) | r > 0              = pi * r ^ 2
                           | otherwise          = 0

      surface (Rectangle (Pt x1 y1) (Pt x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

      result = [surface (Circle (Pt 0 0) 1), surface (Rectangle (Pt 2 3) (Pt 4 5))]
    "}

    assert_raise_compile_error {"
      Error
    "}
  end

  private
    def assert_equal_execute(str, &block)
      Haskell.invoke_sandbox!
      Haskell.compile(block.call)
      nil while Haskell.compiling?
      assert_equal str, Haskell.execute
      Haskell.revoke_sandbox!
    end

    def assert_raise_compile_error(&block)
      Haskell.invoke_sandbox!
      Haskell.compile(block.call)
      nil while Haskell.compiling?
    # TODO: more prefer test
    rescue Haskell::HaskellCompileError
      assert(true)
      Haskell.revoke_sandbox!
    end
end
