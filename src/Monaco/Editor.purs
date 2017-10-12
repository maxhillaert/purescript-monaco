module Monaco.Editor
  ( create
  ) where

import Control.Monad.Aff
import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Promise (toAff, toAffE, Promise)
import DOM (DOM)
import DOM.HTML.Types (HTMLElement)
import Data.Foreign (Foreign, toForeign)
import Monaco.Types (Editor, EditorConstructionOptions, MONACO)
import Prelude ((>>=))
import Type.Row.Effect.Equality (effFrom)
 
foreign import createImpl
  ∷ forall e. Foreign
  -> HTMLElement
  -> Eff (monaco :: MONACO, dom ∷ DOM, exception ∷ EXCEPTION|e) (Promise Editor)

create
  ∷  forall e. 
  EditorConstructionOptions
  -> HTMLElement
  -> Aff (monaco :: MONACO, dom ∷ DOM, exception ∷ EXCEPTION|e) Editor
create options el = 
  let effProm = createImpl (toForeign options) el in
  toAffE effProm

   
 -- liftEff eff >>= toAff