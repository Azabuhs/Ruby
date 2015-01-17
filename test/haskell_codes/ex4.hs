singleSort :: [Integer] -> [Integer]
singleSort [x] = [x]
singleSort (x:y:zs) | x > y     = x : singleSort (y:zs)
                    | otherwise = y : singleSort (x:zs)

bubleSort :: [Integer] -> [Integer]
bubleSort x = iterate singleSort x !! length x

result = bubleSort [2,4,1,3,5]
--
-- bsort []  = []
-- bsort [x] = [x]
-- bsort (x:xs) | x < y     = x : bsort (y:ys)
--              | otherwise = y : bsort (x:ys)
--              where
--              (y:ys) = bsort xs
