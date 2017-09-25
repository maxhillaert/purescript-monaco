module Main where
  
import Prelude

import Control.Monad.Aff (launchAff, runAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, stack, Error)

import Data.Maybe
import Control.Monad.Eff.Console
import DOM (DOM)
import EditorBasic (editor)
import Utils as U
import Control.Monad.Eff.Console
import Debug.Trace

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
      trace (maybe "unknown error" id (stack e)) pure
      

    handleValue :: forall a b. b -> Eff a Unit
    handleValue e = pure unit
  