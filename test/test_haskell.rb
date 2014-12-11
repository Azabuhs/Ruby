require 'minitest_helper'

class TestHaskell < MiniTest::Unit::TestCase
  def setup
    @path = File.expand_path('../', __FILE__)
  end

  def test_main
    assert_equal_execute '3',               get_code(1)
    assert_equal_execute '[3.1415927,4.0]', get_code(2)
    assert_equal_execute 'True',            get_code(3)

    assert_raise_compile_error("Error")
  end

  private
    def assert_equal_execute(str, hs_code)
      Haskell.invoke_sandbox!(@path)
      Haskell.compile(hs_code)
      nil while Haskell.compiling?
      assert_equal str, Haskell.execute
      Haskell.revoke_sandbox!
    end

    def assert_raise_compile_error(hs_code)
      Haskell.invoke_sandbox!(@path)
      Haskell.compile(hs_code)
      nil while Haskell.compiling?
    # TODO: more prefer test
    rescue Haskell::HaskellCompileError
      assert(true)
      Haskell.revoke_sandbox!
    end

    def get_code(num)
      File.read("#{@path}/haskell_codes/ex#{num}.hs")
    end
end
