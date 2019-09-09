module Interpreter.Effs where

import qualified Control.Monad.Freer as Freer
import qualified Control.Monad.Freer.Reader as Reader
import qualified Control.Monad.Freer.Error as Error

import Effect.FileSystem
import Effect.Process
import Effect.Program
import Interpreter.FileSystem
import Interpreter.Process
import Interpreter.Program


runEffs
  :: config
  -> Eff '[Program, FileSystem, Process, Reader config, Error err, IO] a
  -> IO (Either err a)
runEffs config =
  Freer.runM
    . Error.runError
    . Reader.runReader config
    . runProcess
    . runFileSystem
    . runProgram
