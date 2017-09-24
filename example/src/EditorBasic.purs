module EditorBasic where

import Prelude (Unit, bind, pure, unit, ($))

import Utils as U
import Control.Monad.Aff (Aff)

import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (EXCEPTION)
import DOM (DOM)

import DOM.Node.Types (ElementId(..))
import Data.Maybe (Maybe(..))
import Debug.Trace as DT
import Monaco.Editor as ME
import Monaco.Types

editor ∷ ∀ e. Aff (dom ∷ DOM, exception ∷ EXCEPTION |e) Unit
editor = do
  mbEl ← liftEff (U.getElementById $ ElementId "line")
  case mbEl of
    Nothing -> DT.traceAnyA "There is no element with line id"
    Just el -> do
      let options = 
            EditorOptions {
                value : "function x() {\n\tconsole.log(\"Hello world!\");\n}",
                language : "javascript"
            }
      ch <- ME.create options el
      pure unit
  