require 'pry'
module Haskell
  # TODO:
  class HaskellCompileError < StandardError; end
  class << self
    def invoke_sandbox!
      file_path = File.expand_path('../', __FILE__)
      $sandbox_path = "#{file_path}/haskell_executing_sandbox"
      FileUtils.mkdir($sandbox_path) unless Dir.exist?($sandbox_path)
    end

    def revoke_sandbox!
      FileUtils.rm_rf($sandbox_path)
    end

    def compile(hs_code)
      FileUtils.touch("#{$sandbox_path}/COMPILING")
      #TODO: need inform user prefer message
      Thread.abort_on_exception = true
      Thread.new do
        begin
          executable_code = executable_code(hs_code)
          puts_notation(executable_code)
          File.write("#{$sandbox_path}/tmp.hs", executable_code)
          Kernel.system("ghc #{$sandbox_path}/tmp.hs")
          raise HaskellCompileError unless compiled?
        ensure
          FileUtils.rm("#{$sandbox_path}/COMPILING")
        end
      end
    rescue
      raise "Something wrong..."
    end

    def compiling?
      File.exist?("#{$sandbox_path}/COMPILING")
    end

    def compiled?
      File.exist?("#{$sandbox_path}/tmp")
    end

    def execute
      `#{$sandbox_path}/tmp`.gsub(/\n\z/, '')
    end

  private

    def executable_code(hs_code)
      # TODO: other white space
      hs_code =~/\A\n( *)/
      hs_code.gsub!(/\n#{$1}/, "\n")
<<-HASKELL_CODE
module Main where
#{hs_code}
main = do putStrLn $ show result
HASKELL_CODE
    end

    def puts_notation(executable_code)
puts <<-NOTATION
# GHC will compile below code
###############################
NOTATION

puts '# ' + executable_code.gsub("\n", "\n# ")

puts <<-NOTATION
###############################
NOTATION
    end
  end
end
