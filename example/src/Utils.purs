module Utils
  ( getElementById
  , onLoad
  ) where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Except (runExcept)
import Data.Maybe (Maybe(..), fromJust)
import Data.Either (either)
import Data.Foreign (toForeign)
import DOM (DOM)
import DOM.Event.EventTarget (eventListener, addEventListener)
import DOM.HTML (window)
import DOM.HTML.Event.EventTypes (load)
import DOM.HTML.Types (HTMLElement, windowToEventTarget, htmlDocumentToNonElementParentNode, readHTMLElement)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode as NEPN
import DOM.Node.Types (ElementId)
import Partial.Unsafe (unsafePartial)

getElementById
  ∷ forall eff
  . ElementId
  -> Eff (dom ∷ DOM | eff) (Maybe HTMLElement)
getElementById elementId = do
  win <- window
  doc <- document win
  el <- NEPN.getElementById elementId (htmlDocumentToNonElementParentNode doc)
  pure $ either (const Nothing) Just $ runExcept $ readHTMLElement (toForeign <<< unsafePartial fromJust $ el)

onLoad
  ∷ forall eff a
  . Eff (dom ∷ DOM | eff) a
  -> Eff (dom ∷ DOM | eff) Unit
onLoad handler =
  addEventListener load (eventListener (const handler)) false
    <<< windowToEventTarget
    =<< window



