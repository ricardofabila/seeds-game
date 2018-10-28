module Exit exposing
    ( Destination(..)
    , Handle
    , Status
    , ToScene
    , With
    , continue
    , exit
    , exitTo
    , exitWith
    , handle
    , ignore
    , onExit
    )


type alias Status state =
    With () state


type alias ToScene state =
    With Destination state


type Destination
    = ToHub
    | ToIntro
    | ToLevel
    | ToRetry
    | ToSummary
    | ToTutorial


type With payload state
    = Continue state
    | Exit payload state



-- Embedding


continue : model -> List (Cmd msg) -> With payload ( model, Cmd msg )
continue model cmds =
    Continue ( model, Cmd.batch cmds )


exit : model -> With () ( model, Cmd msg )
exit model =
    Exit () ( model, Cmd.none )


exitTo : Destination -> model -> ToScene ( model, Cmd msg )
exitTo destination model =
    Exit destination ( model, Cmd.none )


exitWith : payload -> model -> With payload ( model, Cmd msg )
exitWith payload model =
    Exit payload ( model, Cmd.none )



-- Handlers


type alias Handle payload subMsg subModel model msg =
    { modelF : subModel -> model -> model
    , msgF : subMsg -> msg
    , update : subMsg -> subModel -> With payload ( subModel, Cmd subMsg )
    }


handle =
    Handle


onExit :
    (model -> payload -> ( model, Cmd msg ))
    -> Handle payload subMsg subModel model msg
    -> subMsg
    -> subModel
    -> model
    -> ( model, Cmd msg )
onExit exitF { modelF, msgF, update } subMsg subModel model =
    case update subMsg subModel of
        Continue ( m, cmd ) ->
            ( modelF m model, Cmd.map msgF cmd )

        Exit payload _ ->
            exitF model payload


ignore :
    Handle payload subMsg subModel model msg
    -> subMsg
    -> subModel
    -> model
    -> ( model, Cmd msg )
ignore { modelF, msgF, update } subMsg subModel model =
    case update subMsg subModel of
        Continue ( m, cmd ) ->
            ( modelF m model, Cmd.map msgF cmd )

        Exit _ _ ->
            ( modelF subModel model, Cmd.none )
