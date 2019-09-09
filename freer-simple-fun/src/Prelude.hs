module Prelude
  ( module Relude
  , Reader
  , Error
  , Eff
  , Member
  , LastMember
  , type(~>)
  )
where

import Relude
  hiding (
  -- We hide the MTL parts, since we are using Freer
           Reader
  , ReaderT
  , State
  , StateT
  , ExceptT
  , MaybeT
  )
import Control.Monad.Freer (Eff, Member, LastMember, type(~>))
import Control.Monad.Freer.Reader (Reader)
import Control.Monad.Freer.Error (Error)
