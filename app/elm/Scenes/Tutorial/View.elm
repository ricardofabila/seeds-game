module Scenes.Tutorial.View exposing (..)

import Data.Color exposing (darkYellow)
import Data.Level.Board.Block exposing (getTileState)
import Data.Level.Board.Tile exposing (hasLine, isDragging, tileSize)
import Data.Level.Scale exposing (tileScaleFactor)
import Dict
import Helpers.Style exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Scenes.Level.Types exposing (Move, TileConfig, TileSize, TileState(..), TileType(..))
import Scenes.Tutorial.Types exposing (..)
import Views.Board.Layout exposing (renderLineLayer, renderLines)
import Views.Board.Styles exposing (boardHeight, boardWidth)
import Views.Board.Tile exposing (renderTile_)
import Views.Seed.All exposing (renderSeed)


tutorialView : Model -> Html Msg
tutorialView model =
    div
        [ class "w-100 h-100 fixed top-0 flex items-center justify-center z-5"
        , style [ ( "background-color", "rgba(255, 252, 227, 0.98)" ), transitionStyle "1.2s linear" ]
        , classList
            [ ( "o-0", model.canvasHidden )
            , ( "o-100", not model.canvasHidden )
            ]
        ]
        [ div
            [ style
                [ ( "margin-top", pc -5 )
                , transitionStyle "0.8s linear"
                ]
            , classList
                [ ( "o-0", model.containerHidden )
                , ( "o-100", not model.containerHidden )
                ]
            ]
            [ tutorialBoard model
            , p
                [ style [ ( "color", darkYellow ), transitionStyle "0.5s ease" ]
                , classList [ ( "o-0", model.textHidden ), ( "0-100", not model.textHidden ) ]
                ]
                [ text model.text ]
            ]
        ]


tutorialBoard : Model -> Html msg
tutorialBoard model =
    div
        [ class "center relative"
        , classList [ ( "o-0", model.boardHidden ), ( "0-100", not model.boardHidden ) ]
        , style
            [ widthStyle <| boardWidth model
            , heightStyle <| boardHeight model
            , transitionStyle "0.5s ease"
            ]
        ]
        [ div [ class "absolute z-5" ] [ renderSeedBank model ]
        , div [ class "absolute z-2" ] <| renderTiles model
        , div [ class "absolute z-0" ] <| renderLines_ model
        ]


renderSeedBank : Model -> Html msg
renderSeedBank model =
    let
        ts =
            tileScaleFactor model.window
    in
        div
            [ style
                [ transitionStyle "0.8s ease"
                , transformStyle <| translate (model.tileSize.x * ts) -100
                , widthStyle (model.tileSize.x * ts)
                , heightStyle (model.tileSize.y * ts)
                ]
            , classList
                [ ( "o-0", model.seedBankHidden )
                , ( "o-100", not model.seedBankHidden )
                ]
            ]
            [ renderSeed model.seedType ]


renderLines_ : Model -> List (Html msg)
renderLines_ model =
    model.board
        |> Dict.toList
        |> List.map (fadeLine model)


fadeLine : TileConfig model -> Move -> Html msg
fadeLine model (( _, tile ) as move) =
    if hasLine tile then
        div
            [ style [ transitionStyle "0.5s ease" ]
            , class "o-100"
            ]
            [ renderLineLayer model move ]
    else
        div
            [ style [ transitionStyle "0.5s ease" ]
            , class "o-0"
            ]
            [ renderLineLayer model move ]


renderTiles : Model -> List (Html msg)
renderTiles model =
    model.board
        |> Dict.toList
        |> List.map (\mv -> renderTile_ (leavingStyles model mv) model mv)


leavingStyles : Model -> Move -> List Style
leavingStyles model (( _, block ) as move) =
    let
        tileState =
            getTileState block

        ts =
            tileScaleFactor model.window
    in
        case tileState of
            Leaving Seed order ->
                [ transformStyle <| translate (model.tileSize.x * ts) -100
                , transitionStyle "0.5s ease"
                , transitionDelayStyle <| (order % 5) * 80
                ]

            _ ->
                []
