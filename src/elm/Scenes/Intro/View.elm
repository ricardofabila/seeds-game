module Scenes.Intro.View exposing (introView, renderScene, textOffset)

import Css.Style as Style exposing (Style, background, color, marginTop, showIf, style, width)
import Css.Transition exposing (transitionAll)
import Data.Window as Window
import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Scenes.Intro.Types exposing (..)
import Views.Intro.DyingLandscape exposing (dyingLandscape)
import Views.Intro.GrowingSeeds exposing (growingSeeds)
import Views.Intro.RollingHills exposing (rollingHills)


introView : IntroModel -> Html IntroMsg
introView model =
    div
        [ style
            [ background model.backdrop
            , transitionAll 1500 []
            ]
        , class "fixed top-0 left-0 w-100 h-100 z-1"
        ]
        [ p
            [ style
                [ textOffset model.window
                , color model.textColor
                , transitionAll 1000 []
                ]
            , showIf model.textVisible
            , class "tc f5 f3-ns relative z-2"
            ]
            [ text model.text ]
        , renderScene model
        ]


renderScene : IntroModel -> Html IntroMsg
renderScene model =
    case model.scene of
        DyingLandscape environment vis ->
            dyingLandscape environment vis

        GrowingSeeds vis ->
            growingSeeds model.window vis

        RollingHills vis ->
            rollingHills vis


textOffset : Window.Size -> Style
textOffset window =
    marginTop <| toFloat <| (window.height // 2) - 120
