module Main where
  
import Prelude (Unit, pure, unit)
import Control.Monad.Aff (runAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, Error)
import DOM (DOM)
import EditorBasic (editor)
import Utils as U

