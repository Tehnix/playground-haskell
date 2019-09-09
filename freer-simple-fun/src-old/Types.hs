{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}
module Types where

import Control.Concurrent.STM
import Control.Lens
import Control.Monad.Reader
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map


type App = ReaderT Env IO

data Env = Env
  { envSymTable :: !(TVar SymTable)
  , envLineNo :: !(TVar LineNo)
  , envSteps :: !(TVar Int)
  }

type Identifier = String
type SymAttributesMap = Map Identifier SymAttribute

data SymTable = SymTable
  { symTableParent :: Maybe SymTable
  , symTableAttributes :: SymAttributesMap
  } deriving (Show)

data SymAttribute
  = IdAttr Identifier
  | FunAttr Identifier
  deriving (Show)

data LineNo = LineNo
  { lineNoCurrentNo :: !Int
  , lineNoPreviousNo :: Maybe LineNo
  } deriving (Show)

makeLensesWith camelCaseFields ''SymAttribute
makeLensesWith camelCaseFields ''SymTable
makeLensesWith camelCaseFields ''LineNo
makeLensesWith camelCaseFields ''Env

emptyLineNo :: LineNo
emptyLineNo = LineNo { lineNoCurrentNo = 0, lineNoPreviousNo = Nothing }

emptySymbolTable :: SymTable
emptySymbolTable =
  SymTable { symTableParent = Nothing, symTableAttributes = Map.empty }

incLineNo :: (Num a, HasCurrentNo t a) => a -> t -> t
incLineNo n = over currentNo (+ n)

modifyLineNo
  :: (HasLineNo env (TVar a), MonadIO m, MonadReader env m) => (a -> a) -> m ()
modifyLineNo f = do
  env <- ask
  liftIO $ atomically $ modifyTVar' (env ^. lineNo) f

modifySteps
  :: (HasSteps env (TVar a), MonadIO m, MonadReader env m) => (a -> a) -> m ()
modifySteps f = do
  env <- ask
  liftIO $ atomically $ modifyTVar' (env ^. steps) f
