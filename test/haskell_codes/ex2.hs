data Point = Pt Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)
surface :: Shape -> Float
surface (Circle _ r) | r > 0              = pi * r ^ 2
                     | otherwise          = 0

surface (Rectangle (Pt x1 y1) (Pt x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

result = [surface (Circle (Pt 0 0) 1), surface (Rectangle (Pt 2 3) (Pt 4 5))]
