module Lib where

import Polysemy

-- Our effects.
data Teletype m a where
  ReadTTY  :: Teletype m String
  WriteTTY :: String -> Teletype m ()
makeSem ''Teletype

-- Our interpreter.
runIOTeletype :: Member (Embed IO) r => Sem (Teletype ': r) a -> Sem r a
runIOTeletype = interpret $ \case
  ReadTTY      -> embed getLine
  WriteTTY msg -> embed $ putStrLn msg

-- Our program.
echo :: Member Teletype r => Sem r ()
echo = do
  i <- readTTY
  case i of
    "" -> pure ()
    _  -> writeTTY i >> echo
