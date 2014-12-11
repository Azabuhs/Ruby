add1 :: Maybe Int -> Maybe Int -> Maybe Int
add2 :: Maybe Int -> Maybe Int -> Maybe Int
add3 :: Maybe Int -> Maybe Int -> Maybe Int

add1 mx my =
  case mx of
    Nothing -> Nothing
    Just x  -> case my of
      Nothing -> Nothing
      Just y  -> Just (x + y)


add2 mx my =
  mx >>= (\x ->
    my >>= (\y ->
      return (x + y)))


add3 mx my = do
  x <- mx
  y <- my
  return (x + y)

exAdd1 :: Maybe Int
exAdd2 :: Maybe Int
exAdd3 :: Maybe Int
exAdd1 = add1 (Just 1) (Just 2)
exAdd2 = add2 (Just 1) (Just 2)
exAdd3 = add3 (Just 1) (Just 2)

result = (exAdd1 == exAdd2) && (exAdd2 == exAdd3)
