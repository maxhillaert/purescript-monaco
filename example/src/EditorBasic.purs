module EditorBasic where

import Control.Monad.Aff (Aff)
import Control.Monad.Aff (Aff, launchAff_)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Exception (EXCEPTION, Error)
import DOM (DOM)
import DOM.Node.Types (ElementId(..))
import Data.Maybe (Maybe(..))
import Debug.Trace (traceAnyM, trace)
import Monaco.Editor as ME
import Monaco.Types (MONACO)
import Monaco.Types as MT
import Prelude (Unit, bind, pure, unit, ($))
import Utils as U
import Utils as U



editor ∷ forall e. Aff (monaco :: MONACO, dom ∷ DOM, exception ∷ EXCEPTION |e) Unit
editor = do
  mbEl <- liftEff (U.getElementById $ ElementId "line")
  case mbEl of
    Nothing -> pure unit
    Just el -> do
      let options = 
                  MT.defaultConstuctorOptions 
                  { value = Just "function x() {\n\tconsole.log(\"Hello world!\");\n}" 
                  , language = Just "javascript"
                  , theme = Just "vs-dark"
                  , fontWeight = Just MT.fontWeightBolder
                  , fontSize = Just 16.0
                  }
      let e = ME.create options el
      let x = trace "Hey"
      ch <- e
      _ <- traceAnyM ch
      pure unit

main
  ∷ forall e
  . Eff ( dom ∷ DOM
        , monaco :: MONACO
        , exception ∷ EXCEPTION, exception ∷ EXCEPTION
        | e )
      Unit
main =  U.onLoad do 
        launchAff_ editor
  
  
  