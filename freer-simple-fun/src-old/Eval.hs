{-# LANGUAGE FlexibleContexts #-}

module Eval where

import Control.Concurrent.STM
import Control.Lens
import Control.Monad.Reader
import GHC.Conc (unsafeIOToSTM)
import Say
import UnliftIO.Concurrent

import Types

eval :: (HasSteps env (TVar Int), MonadIO m, MonadReader env m) => m ()
eval = do
  env <- ask
  let tvarSteps = env ^. steps
  s <- liftIO $ waitForSteps tvarSteps
  sayString $ "   Took a step " ++ show s
  threadDelay 500000 -- Wait 0.5 second to simulate evaluation.
  eval

waitForSteps :: (Ord a, Num a) => TVar a -> IO a
waitForSteps tvar = atomically $ waitForStepsStm tvar

waitForStepsStm :: (Ord a, Num a) => TVar a -> STM a
waitForStepsStm tvar = do
  s <- readTVar tvar
  if s > 0
    then do
      modifyTVar' tvar (\x -> x - 1)
      readTVar tvar
    else retry
