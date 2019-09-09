{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DuplicateRecordFields #-}
module Lib where
import Optics.TH (makeFieldLabelsWith, classUnderscoreNoPrefixFields)
import Optics (view, set, (%))


data World = World { _party :: Party } deriving Show
data Party = Party { _firstHuman :: Human } deriving Show
data Human = Human { _name :: String, _pet :: Pet } deriving Show
data Pet = Pet { _name :: String } deriving Show

$(makeFieldLabelsWith classUnderscoreNoPrefixFields ''World)
$(makeFieldLabelsWith classUnderscoreNoPrefixFields ''Party)
$(makeFieldLabelsWith classUnderscoreNoPrefixFields ''Human)
$(makeFieldLabelsWith classUnderscoreNoPrefixFields ''Pet)

nestedRecord :: World
nestedRecord =
  World {_party = Party {_firstHuman = Human "Peter" (Pet "Sparky")}}

updatePetName :: String -> World -> World
updatePetName = set (#party % #firstHuman % #pet % #name)

updateHumanName :: String -> World -> World
updateHumanName = set (#party % #firstHuman % #name)
