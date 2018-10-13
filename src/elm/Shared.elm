module Shared exposing
    ( Data
    , decrementLife
    , hideLoadingScreen
    , incrementMessageIndex
    , incrementProgress
    , setCurrentLevel
    , setWindow
    , showLoadingScreen
    , updateLives
    )

import Data.Background exposing (Background)
import Data.Level.Progress as Progress
import Data.Level.Types exposing (AllLevels, Progress)
import Data.Lives as Lives exposing (Lives)
import Data.Window as Window
import Time


type alias Data =
    { window : Window.Size
    , loadingScreen : Maybe Background
    , progress : Progress
    , currentLevel : Maybe Progress
    , successMessageIndex : Int
    , lives : Lives
    }


setCurrentLevel : Maybe Progress -> Data -> Data
setCurrentLevel level data =
    { data | currentLevel = level }


showLoadingScreen : Background -> Data -> Data
showLoadingScreen background data =
    { data | loadingScreen = Just background }


hideLoadingScreen : Data -> Data
hideLoadingScreen data =
    { data | loadingScreen = Nothing }


setWindow : Int -> Int -> Data -> Data
setWindow width height data =
    { data | window = Window.Size width height }


incrementProgress : AllLevels a -> Data -> Data
incrementProgress allLevels data =
    { data | progress = Progress.incrementProgress allLevels data.currentLevel data.progress }


incrementMessageIndex : Data -> Data
incrementMessageIndex data =
    { data | successMessageIndex = data.successMessageIndex + 1 }


updateLives : Time.Posix -> Data -> Data
updateLives now data =
    { data | lives = Lives.update now data.lives }


decrementLife : Data -> Data
decrementLife data =
    { data | lives = Lives.decrement data.lives }
