module Scenes.Hub.State exposing (init, scrollHubToLevel, update)

import Browser.Dom as Dom
import Data.InfoWindow as InfoWindow
import Data.Window as Window
import Delay exposing (after)
import Helpers.Delay exposing (sequenceMs)
import Scenes.Hub.Types as Hub exposing (..)
import Task exposing (Task)


init : Int -> HubModel model -> ( HubModel model, Cmd HubMsg )
init levelNumber model =
    ( model
    , after 1000 Delay.Millisecond <| ScrollHubToLevel levelNumber
    )



-- Update


update : HubMsg -> HubModel model -> ( HubModel model, Cmd HubMsg )
update msg model =
    case msg of
        SetInfoState infoWindow ->
            ( { model | hubInfoWindow = infoWindow }
            , Cmd.none
            )

        ShowLevelInfo levelProgress ->
            ( { model | hubInfoWindow = InfoWindow.show levelProgress }
            , Cmd.none
            )

        HideLevelInfo ->
            ( model
            , sequenceMs
                [ ( 0, SetInfoState <| InfoWindow.leave model.hubInfoWindow )
                , ( 1000, SetInfoState InfoWindow.hidden )
                ]
            )

        ScrollHubToLevel level ->
            ( model
            , scrollHubToLevel level
            )

        DomNoOp _ ->
            ( model
            , Cmd.none
            )



-- Update Helpers


scrollHubToLevel : Int -> Cmd HubMsg
scrollHubToLevel levelNumber =
    getLevelId levelNumber
        |> Dom.getElement
        |> Task.andThen scrollLevelToView
        |> Task.attempt DomNoOp


scrollLevelToView : Dom.Element -> Task Dom.Error ()
scrollLevelToView { element, viewport } =
    Dom.setViewportOf "hub" 0 <| element.y - viewport.height / 2


getLevelId : Int -> String
getLevelId levelNumber =
    "level-" ++ String.fromInt levelNumber
