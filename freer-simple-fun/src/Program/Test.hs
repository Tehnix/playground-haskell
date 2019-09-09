{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Program.Test where

import qualified Control.Monad.Freer.Reader as Reader
import qualified Control.Monad.Freer.Error as Error
import Control.Lens ((^.))

import Effect.FileSystem
import Effect.Process
import Effect.Program
import Types


-- HasAwsCredentials env Text
conditionerProgram
  :: forall env effs
   . (HasAwsCredentials env Text, WithEffs env AppError effs)
  => Eff effs ()
conditionerProgram = do
  notify "Test"
  preCondition <- preProgram @env
  case preCondition of
    Left  msg -> notify msg
    Right _   -> do
      cond <- condProgram
      case cond of
        Left  msg -> notify msg
        Right _   -> postProgram

preProgram
  :: forall env effs
   . ( HasAwsCredentials env Text
     , Member Program effs
     , Member FileSystem effs
     , Member Process effs
     , Member (Reader env) effs
     )
  => Eff effs (Either Text Bool)
preProgram = do
  hasYarn <- hasCmd "yarn"
  config  <- Reader.ask @env
  output $ config ^. awsCredentials
  if hasYarn then output "Has yarn!" else output "Does not have yarn!"
  hasDir <- directoryExists "Repos Dir"
  if hasDir then pure $ Right True else pure $ Left "Could not find dir!"

condProgram
  :: (Member Program effs, Member (Error AppError) effs)
  => Eff effs (Either Text Bool)
condProgram = do
  output "Building..."
  Error.throwError $ CommandFailed "Testing...."
  output "Compiling"
  pure $ Right True

postProgram :: (Member Program effs, Member FileSystem effs) => Eff effs ()
postProgram = do
  hasDir <- directoryExists "Build Dir"
  if hasDir then notify "Done!" else output "Wuut"
