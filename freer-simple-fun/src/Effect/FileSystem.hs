{-# LANGUAGE TemplateHaskell #-}
module Effect.FileSystem where

import Control.Monad.Freer.TH (makeEffect)


data FileSystem next where
  DirectoryExists :: String -> FileSystem Bool

makeEffect ''FileSystem
