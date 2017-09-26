module Main where
  
import Prelude (Unit, pure, unit)
import Control.Monad.Aff (runAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, Error)
import DOM (DOM)
import EditorBasic (editor)
import Utils as U


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
  