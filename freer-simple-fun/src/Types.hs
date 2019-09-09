{-# LANGUAGE TemplateHaskell #-}
module Types where

import Control.Lens (makeLensesWith, camelCaseFields, makePrisms)

import Effect.FileSystem
import Effect.Process
import Effect.Program


type WithEffs c e effs = (Member Program effs, Member FileSystem effs, Member Process effs, Member (Reader c) effs, Member (Error e) effs)

data AppError = ProgramError Text | CommandFailed Text

makePrisms ''AppError

data Config = Config
  { configAwsCredentials :: Text
  , configOrganization :: Text
  } deriving (Show)

makeLensesWith camelCaseFields ''Config
