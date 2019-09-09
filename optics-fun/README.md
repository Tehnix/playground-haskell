# Optics
This library plays around with the new [Optics library](https://www.well-typed.com/blog/2019/09/announcing-the-optics-library/) ([Reddit Thread](https://www.reddit.com/r/haskell/comments/cyo4o2/welltyped_announcing_the_optics_library/)), released as an alternative to Lenses.

A taster,

```haskell
nestedRecord :: World
nestedRecord =
  World {_party = Party {_firstHuman = Human "Peter" (Pet "Sparky")}}

updatePetName :: String -> World -> World
updatePetName = set (#party % #firstHuman % #pet % #name)

updateHumanName :: String -> World -> World
updateHumanName = set (#party % #firstHuman % #name)
```

We can see that it's quite easy to update nested records. Of course the above code uses a bunch of features, e.g. like this bunch of language extensions:

```haskell
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DuplicateRecordFields #-}
```

Check out `src/Lib.hs` for the full example.
