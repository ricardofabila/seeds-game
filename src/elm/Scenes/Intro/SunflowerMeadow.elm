module Scenes.Intro.SunflowerMeadow exposing
    ( State(..)
    , view
    )

import Css.Animation as Animation exposing (animation)
import Css.Color as Color
import Css.Style as Style exposing (Style)
import Css.Transform as Transform
import Css.Transition as Transition
import Data.Window as Window exposing (Window)
import Helpers.Svg exposing (..)
import Html exposing (Html, div)
import Html.Attributes
import Svg exposing (Attribute, Svg)
import Svg.Attributes exposing (..)
import Views.Flowers.Sunflower as Sunflower
import Views.Landscape.RollingHills as Hills


type State
    = Blooming
    | Entering
    | Hidden


view : Window -> State -> Html msg
view window state =
    div []
        [ div
            [ class "z-5 center relative"
            , Style.style [ Style.width 200 ]
            ]
            [ Sunflower.animated 0 ]
        , hills window state
        ]


hills window state =
    Svg.svg [ windowViewBox_ window, class "fixed top-0 z-1" ]
        [ Hills.doubleLayer window ( "#9ae9af", [] ) ( "#46cda2", [] ) |> offsetBy window state -500 1500
        , Hills.doubleLayer window ( "#22c37c", [] ) ( "#225941", [] ) |> offsetBy window state -400 1200
        , Hills.doubleLayer window ( "#27af76", [] ) ( "#339576", [] ) |> offsetBy window state -300 1000
        , Hills.doubleLayer window ( "#62DE83", [] ) ( "#15674D", [] ) |> offsetBy window state -200 800
        , Hills.doubleLayer window ( "#22c37c", flowersLeft window state 500 ) ( "#225941", flowersRight window state 500 )
            |> offsetBy window state -100 600
        , Hills.doubleLayer window ( "#277854", flowersLeft window state 250 ) ( "#17A667", flowersRight window state 250 )
            |> offsetBy window state 0 400
        , Hills.doubleLayer window ( "#2cd99b", flowersLeft window state 0 ) ( "#339576", flowersRight window state 0 )
            |> offsetBy window state 100 200
        , Hills.doubleLayer window ( "#169a63", [] ) ( "#15674D", [] ) |> offsetBy window state 200 0
        ]


offsetBy window state offset delay el =
    Svg.g [ offsetStyles window state offset delay ] [ el ]


offsetStyles window state offset delay =
    let
        translateY n =
            Style.transform [ Transform.translateY n ]

        visibleStyles =
            Style.svgStyle
                [ translateY offset
                , Transition.transition "transform" 2000 [ Transition.cubicBezier 0 0 0 1, Transition.delay delay ]
                ]
    in
    case state of
        Hidden ->
            Style.svgStyle
                [ translateY <| toFloat <| window.height // 2
                ]

        Entering ->
            visibleStyles

        Blooming ->
            visibleStyles


flowersLeft window state delay =
    let
        range =
            windowRange window
    in
    [ Hills.element (range 14 18 23) 0 <| scaled (range 0.6 1 1.2) <| sunflower window state delay
    , Hills.element (range 9 13.5 18) 0 <| scaled (range 0.5 0.8 1) <| sunflower window state (delay + 150)
    , Hills.element (range 5 9.5 13) 0 <| scaled (range 0.4 0.6 0.8) <| sunflower window state (delay + 300)
    ]


flowersRight window state delay =
    let
        range =
            windowRange window
    in
    [ Hills.element (range -14 -18 -23) 0 <| scaled (range 0.6 1 1.2) <| sunflower window state delay
    , Hills.element (range -9 -13.5 -18) 0 <| scaled (range 0.5 0.8 1) <| sunflower window state (delay + 150)
    , Hills.element (range -5 -9.5 -13) 0 <| scaled (range 0.4 0.6 0.8) <| sunflower window state (delay + 300)
    ]


windowRange window narrow medium wide =
    case Window.width window of
        Window.Narrow ->
            narrow

        Window.MediumWidth ->
            medium

        Window.Wide ->
            wide


sunflower window state delay =
    case state of
        Blooming ->
            Svg.svg
                [ viewBox_ 0 0 30 30
                , width_ 60
                , height_ 60
                ]
                [ animateSunflower window delay ]
                |> translated -30 -30

        _ ->
            Svg.g [] []


animateSunflower window delay =
    case Window.size window of
        Window.Small ->
            Svg.g
                [ Style.svgStyle
                    [ Animation.animation "fade-in"
                        1000
                        [ Animation.delay <| (delay * 150) // 100
                        , Animation.linear
                        ]
                    , Style.opacity 0
                    ]
                ]
                [ Sunflower.static ]

        _ ->
            Sunflower.animated delay
