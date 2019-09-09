module Interpreter.Process where

import qualified Control.Monad.Freer as Freer

import Effect.Process


runProcess :: (LastMember IO effs) => Eff (Process ': effs) ~> Eff effs
runProcess = Freer.interpretM
  (\case
    HasCmd _ -> pure True
  )
