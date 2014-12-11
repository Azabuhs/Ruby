# Haskell On Ruby

```rb
require 'haskell'

# Invoke sandbox for executing ghc
Haskell.invoke_sandbox!(File.expand_path('../', __FILE__))

Haskell.compile %{
  add :: Integer -> Integer -> Integer
  add x y = x + y
  result = add 1 2
}

while Haskell.compiling?
  # wait for....
end

p Haskell.execute
#=> 3

# Don't forget to revoke sandbox
Haskell.revoke_sandbox!
```
