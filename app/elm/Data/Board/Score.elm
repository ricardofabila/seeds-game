module Data.Board.Score exposing (..)

import Data.Move.Utils exposing (currentMoves)
import Data.Move.Type exposing (currentMoveTileType)
import Dict
import Scenes.Level.Model exposing (..)


handleAddScore : Model -> Model
handleAddScore model =
    { model | scores = addScoreFromMoves model.board model.scores }


addScoreFromMoves : Board -> Scores -> Scores
addScoreFromMoves board scores =
    let
        tileType =
            currentMoveTileType board |> Maybe.withDefault SeedPod

        scoreToAdd =
            currentMoves board |> List.length
    in
        addToScore scoreToAdd tileType scores


scoreToString : TileType -> Scores -> String
scoreToString tileType scores =
    getScoreFor tileType scores
        |> Maybe.map toString
        |> Maybe.withDefault ""


getScoreFor : TileType -> Scores -> Maybe Int
getScoreFor tileType scores =
    Dict.get (toString tileType) scores


addToScore : Int -> TileType -> Scores -> Scores
addToScore score tileType scores =
    scores |> Dict.update (toString tileType) (Maybe.map ((+) score))


initialScores : List TileType -> Scores
initialScores tileTypes =
    tileTypes
        |> List.filter ((/=) SeedPod)
        |> List.map toString
        |> List.map (\tile -> ( tile, 0 ))
        |> Dict.fromList
