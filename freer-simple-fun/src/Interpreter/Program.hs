module Interpreter.Program where

import qualified Control.Monad.Freer as Freer

import Effect.Program


runProgram :: (LastMember IO effs) => Eff (Program ': effs) ~> Eff effs
runProgram = Freer.interpretM
  (\case
    Output s -> do
      putTextLn s
      pure ()
    Notify s -> do
      putTextLn $ "Notifying: " <> s
      pure ()
    Noop _ -> pure ()
  )
