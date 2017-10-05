module EditorOptions 
where
  
import Monaco.Types

import Control.Monad.Aff (Aff)
import Control.Monad.Aff (runAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Exception (EXCEPTION, Error)
import DOM (DOM)
import DOM.Event.TouchEvent (targetTouches)
import DOM.Node.Types (ElementId(..))
import Data.Maybe (Maybe(..))
import Monaco.Editor as ME
import Monaco.Types as MT
import Prelude (Unit, bind, pure, unit, ($))
import Utils as U


editor ∷ forall e. Aff (dom ∷ DOM, exception ∷ EXCEPTION |e) Unit
editor = do
  mbEl <- liftEff (U.getElementById $ ElementId "line")
  case mbEl of
    Nothing -> pure unit
    Just el -> do                                 
      let options = MT.defaultConstuctorOptions 
                    { value = Just "function x() {\n\tconsole.log(\"Hello world!\");\n}" 
                    , language = Just "javascript"
                    , theme = Just "vs-dark"
                    , ariaLabel = Nothing
                    , rulers = Just ([5.0, 10.0])
                    , wordSeparators = Nothing
                    , selectionClipboard = Nothing
                    , lineNumbers = Just (lineNumberFunction (\n->"042"))
                    , selectOnLineNumbers = Just false
                    , lineNumbersMinChars = Just 4.0
                    , glyphMargin = Nothing
                    , lineDecorationsWidth = Nothing
                    , revealHorizontalRightPadding = Nothing
                    , roundedSelection = Nothing
                    , extraEditorClassName = Nothing
                    , readOnly = Nothing
                    , scrollbar = Just  { arrowSize : Just 30.0
                                        , vertical : Just MT.scrollbarVisibilityVisible
                                        , horizontal : Just MT.scrollbarVisibilityVisible
                                        , useShadows : Just true
                                        , verticalHasArrows : Just true
                                        , horizontalHasArrows : Just true
                                        , handleMouseWheel : Just true
                                        , horizontalScrollbarSize : Nothing
                                        , verticalScrollbarSize : Nothing
                                        , verticalSliderSize : Nothing
                                        , horizontalSliderSize : Nothing
                                        }
                    , minimap = Just    { enabled : Just true 
                                        , showSlider : Just showSliderAlways
                                        , renderCharacters : Just false
                                        , maxColumn : Just 60
                                        }
                    , find = Just       { seedSearchStringFromSelection : Just false
                                        , autoFindInSelection : Just true
                                        }
                    , fixedOverflowWidgets = Nothing
                    , overviewRulerLanes = Nothing
                    , overviewRulerBorder = Nothing
                    , cursorBlinking = Nothing
                    , mouseWheelZoom = Nothing
                    , cursorStyle = Nothing
                    , fontLigatures = Nothing
                    , disableLayerHinting = Nothing
                    , disableMonospaceOptimizations = Nothing
                    , hideCursorInOverviewRuler = Nothing
                    , scrollBeyondLastLine = Nothing
                    , automaticLayout = Nothing
                    , wordWrap = Nothing
                    , wordWrapColumn = Nothing
                    , wordWrapMinified = Nothing
                    , wrappingIndent = Nothing
                    , wordWrapBreakBeforeCharacters = Nothing
                    , wordWrapBreakAfterCharacters = Nothing
                    , wordWrapBreakObtrusiveCharacters = Nothing
                    , stopRenderingLineAfter = Nothing
                    , hover = Nothing
                    , links = Nothing
                    , contextmenu = Nothing
                    , mouseWheelScrollSensitivity = Nothing
                    , multiCursorModifier = Nothing
                    , accessibilitySupport = Nothing
                    , quickSuggestions = Nothing
                    , quickSuggestionsDelay = Nothing
                    , parameterHints = Nothing
                    , iconsInSuggestions = Nothing
                    , autoClosingBrackets = Nothing
                    , autoIndent = Nothing
                    , formatOnType = Nothing
                    , formatOnPaste = Nothing
                    , dragAndDrop = Nothing
                    , suggestOnTriggerCharacters = Nothing
                    , acceptSuggestionOnEnter = Nothing
                    , acceptSuggestionOnCommitCharacter = Nothing
                    , snippetSuggestions = Nothing
                    , emptySelectionClipboard = Nothing
                    , wordBasedSuggestions = Nothing
                    , suggestFontSize = Nothing
                    , suggestLineHeight = Nothing
                    , selectionHighlight = Nothing
                    , occurrencesHighlight = Nothing
                    , codeLens = Nothing
                    , folding = Nothing
                    , showFoldingControls = Nothing
                    , matchBrackets = Nothing
                    , renderWhitespace = Nothing
                    , renderControlCharacters = Nothing
                    , renderIndentGuides = Nothing
                    , renderLineHighlight = Nothing
                    , useTabStops = Nothing
                    , fontFamily = Nothing
                    , fontWeight = Nothing
                    , fontSize = Nothing
                    , lineHeight = Nothing
                    , letterSpacing = Nothing
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
  
  