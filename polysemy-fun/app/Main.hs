module Main where

import Polysemy (runM)

import Lib

main :: IO ()
main = runM . runIOTeletype $ echo
