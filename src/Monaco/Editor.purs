module Monaco.Editor
  ( create
  ) where

import Prelude ((>>=))

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (EXCEPTION)
import DOM (DOM)

import Control.Monad.Aff
import DOM.HTML.Types (HTMLElement)
import Control.Promise(toAff,Promise)
import Data.Foreign (Foreign, toForeign)
import Monaco.Types (Editor, EditorConstructionOptions) 
 

foreign import createImpl
  ∷ forall e. Foreign
  -> HTMLElement
  -> Eff (dom ∷ DOM, exception ∷ EXCEPTION|e) (Promise Editor)

create
  ∷  forall e. 
  EditorConstructionOptions
  -> HTMLElement
  -> Aff (dom ∷ DOM, exception ∷ EXCEPTION|e) Editor
create options el = liftEff (createImpl (toForeign options) el) >>= toAff