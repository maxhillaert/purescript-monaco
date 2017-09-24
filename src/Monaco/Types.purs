module Monaco.Types where

foreign import data Editor ∷ Type

newtype EditorOptions = EditorOptions {
    value :: String,
    language :: String
} 


