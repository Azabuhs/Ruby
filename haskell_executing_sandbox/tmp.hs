module Main where

add :: Integer -> Integer -> Integer
add x y = x + y
result = add 1 2

main = do putStrLn $ show result
