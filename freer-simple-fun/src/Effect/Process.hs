{-# LANGUAGE TemplateHaskell #-}
module Effect.Process where

import Control.Monad.Freer.TH (makeEffect)


data Process next where
  HasCmd :: String -> Process Bool

makeEffect ''Process
