module Lib where

import Control.Concurrent.Async.Lifted.Safe
import Control.Concurrent.STM
import Control.Lens
import Control.Monad.Reader
import Say

import Eval
import Repl
import Types

lib :: IO ()
lib = do
  refSymTable <- newTVarIO emptySymbolTable
  refLineNo <- newTVarIO emptyLineNo
  refSteps <- newTVarIO 0
  let env =
        Env
        {envSymTable = refSymTable, envLineNo = refLineNo, envSteps = refSteps}
  sayString "Starting repl..."
  -- Use `race` to quit whenever either the repl or evaluation finishes.
  runReaderT (race repl eval) env
  -- concurrently (modifyLineNo (incLineNo 1)) (modifySteps (+ 1))
  lineNo <- readTVarIO refLineNo
  step <- readTVarIO refSteps
  sayString $ "Final Line Number: " ++ show lineNo
  sayString $ "Final Step Number: " ++ show step
