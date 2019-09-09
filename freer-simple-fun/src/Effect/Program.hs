{-# LANGUAGE TemplateHaskell #-}
module Effect.Program where

import Control.Monad.Freer.TH (makeEffect)


data Program next where
  Output :: Text -> Program ()
  Notify :: Text -> Program ()
  Noop :: a -> Program ()

makeEffect ''Program
