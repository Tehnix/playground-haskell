module Lib where

someFunc :: IO ()
someFunc = anotherFunc 10

anotherFunc :: Int -> IO ()
anotherFunc a = print $ 1 + 200 + a
