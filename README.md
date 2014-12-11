# Haskell On Ruby

```rb
require 'haskell'
Haskell.compile %{
  add :: Integer -> Integer -> Integer
  add x y = x + y
  result = add 1 2
}

while Haskell.compiling?
...
end

p Haskell.execute
#=> 3
```
