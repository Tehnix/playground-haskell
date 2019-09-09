module Lib where

import Interpreter.Effs
import Program.Test
import Types


main :: IO ()
main = do
  putTextLn ""
  putTextLn "-------------------"
  let
    config = Config
      { configAwsCredentials = "Test Creds"
      , configOrganization   = "Codetalk"
      }
  res <- runEffs config (conditionerProgram @Config)
  case res of
    Left  (ProgramError  s) -> putTextLn $ "program error: " <> s
    Left  (CommandFailed s) -> putTextLn $ "command failed: " <> s
    Right _                 -> putTextLn "Good!"
