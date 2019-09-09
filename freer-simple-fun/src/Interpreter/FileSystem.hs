module Interpreter.FileSystem where

import qualified Control.Monad.Freer as Freer

import Effect.FileSystem


runFileSystem :: (LastMember IO effs) => Eff (FileSystem ': effs) ~> Eff effs
runFileSystem = Freer.interpretM
  (\case
    DirectoryExists _ -> pure True
  )
