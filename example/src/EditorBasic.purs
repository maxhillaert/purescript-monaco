module EditorBasic where

import Prelude (Unit, bind, pure, unit, ($))
import Utils as U
import Control.Monad.Aff (Aff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (EXCEPTION)
import DOM (DOM)
import DOM.Node.Types (ElementId(..))
import Data.Maybe (Maybe(..))
import Monaco.Editor as ME
import Monaco.Types as MT
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, Error)
import Control.Monad.Aff (runAff)
import Utils as U



editor ∷ forall e. Aff (dom ∷ DOM, exception ∷ EXCEPTION |e) Unit
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
      ch <- ME.create options el
      pure unit


main
  ∷ forall e
  . Eff ( dom ∷ DOM
        , exception ∷ EXCEPTION, exception ∷ EXCEPTION
        | e )
      Unit
main =  U.onLoad do 
        runAff handleError handleValue editor
  where
    handleError :: forall a. Error -> Eff a Unit
    handleError e = 
      --trace (maybe "unknown error" id (stack e)) pure
      pure unit
      
    handleValue :: forall a b. b -> Eff a Unit
    handleValue e = pure unit
  
  