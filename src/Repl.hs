{-# LANGUAGE FlexibleContexts #-}
module Repl where

import System.Console.Haskeline
import Control.Monad.Reader
import Control.Concurrent.STM
import UnliftIO.Concurrent
import Control.Lens
import Say
import Text.Read (readMaybe)

import Types

data Cmd
  = Next Int
  | End
  | Invalid


repl :: (HasSteps env (TVar Int), MonadIO m, MonadReader env m) => m ()
repl = do
  env <- ask
  let tvarSteps = env^.steps
  -- Make sure the steps are at 0 before showing the prompt.
  liftIO $ isReady tvarSteps
  -- Get the user command to run.
  cmd <- liftIO $ runInputT defaultSettings getInput
  case cmd of
    Next n -> do
      sayString $ "Adding " ++ show n ++ " steps!"
      -- Update the new steps.
      liftIO $ setSteps tvarSteps n
      repl
    End -> pure ()
    Invalid -> do
      sayString "Incorrect command usage: try 'next <int>'"
      repl
  where
    setSteps :: (Ord a, Num a) => TVar a -> a -> IO ()
    setSteps tvarSteps n = atomically $ modifyTVar' tvarSteps (+ n)
    isReady :: (Ord a, Num a) => TVar a -> IO ()
    isReady tvarSteps = atomically $ do
      s <- readTVar tvarSteps
      if s <= 0
        then pure ()
        else retry

-- | Parse the user input into `Cmd`.
getInput :: InputT IO Cmd
getInput = do
  cmd <- getInputLine ">> "
  return $ parseCmd cmd
  where
    parseCmd :: Maybe String -> Cmd
    parseCmd Nothing = Invalid
    parseCmd (Just cmd) =
      case words cmd of
        ["next"] -> Next 1
        ["next", steps] ->
          case readMaybe steps :: Maybe Int of
            Nothing -> Invalid
            Just s -> Next s
        [":q"] -> End
        [":quit"] -> End
        _ -> Invalid
