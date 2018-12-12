module Views.Flowers.Chrysanthemum exposing (animated, static)

import Css.Animation as Animation
import Css.Style as Style
import Helpers.Svg exposing (..)
import Svg exposing (Svg)
import Svg.Attributes exposing (..)


static : Svg msg
static =
    Svg.svg [ viewBox_ 0 0 433 248 ]
        [ Svg.g [] corePetals
        , Svg.g [] leftOuterPetals
        , Svg.g [] rightOuterPetals
        ]


animated : Int -> Svg msg
animated delay =
    Svg.svg [ viewBox_ 0 0 433 248 ]
        [ Svg.g [] <| animatedCore delay
        , scaleInFade delay leftOuterPetals
        , scaleInFade delay rightOuterPetals
        ]


scaleInFade : Int -> List (Svg msg) -> Svg msg
scaleInFade delay elements =
    Svg.g
        [ Style.svgStyles
            [ Animation.animation "fade-in" 500 [ Animation.linear, Animation.delay delay ]
            , Style.opacity 0
            ]
        ]
        [ Svg.g
            [ Style.svgStyles
                [ Animation.animation "scale-in" 2000 [ Animation.ease, Animation.delay delay ]
                , Style.transformOriginPx (433 / 2) 248
                ]
            ]
            elements
        ]


animatedCore : Int -> List (Svg msg)
animatedCore delay =
    let
        delays =
            List.reverse <| List.range 0 (List.length corePetals - 1)
    in
    List.map2 (animateCorePetal delay) delays corePetals


animateCorePetal : Int -> Int -> Svg msg -> Svg msg
animateCorePetal delay i petal =
    Svg.g
        [ Style.svgStyles
            [ Style.opacity 0
            , Animation.animation "bulge-mini" 500 [ Animation.delay <| (i * 38) + 1300 + delay ]
            , Style.transformOriginPx (433 / 2) 248
            ]
        ]
        [ petal ]


leftOuterPetals : List (Svg msg)
leftOuterPetals =
    [ Svg.g [] [ Svg.path [ d "M212 246l-50-16c-40-13-68-56-82-90-14-33 5-94-35-101-23-4-45 25-34 75 9 36 27 64 54 83 12 9 23 16 34 22 68 38 113 27 113 27z", fill "#c225da" ] [] ]
    , Svg.g [] [ Svg.path [ d "M110 167s-11 0-35-5c-14-3-33-2-42-21-3-7 6-18-1-30-7-14-30-14-32 8-1 21 7 38 23 49 21 14 46 23 99 27l-12-28z", fill "#510f5b" ] [] ]
    , Svg.g [] [ Svg.path [ d "M181 234c-19-6-28-7-72-92-13-25-4-69-35-75-17-4-38 11-31 68 2 12 12 49 43 74 54 45 133 37 133 37l-38-12z", fill "#da2583" ] [] ]
    , Svg.g [] [ Svg.path [ d "M148 205s-14 3-52-6c-14-3-33-2-42-21-3-6 5-17-1-30-7-13-30-13-32 8s7 39 23 50c20 13 51 22 104 26v-27z", fill "#9016a3" ] [] ]
    , Svg.g [] [ Svg.path [ d "M175 241s-1-13-34-15c-12-1-43-6-53-21-4-6 2-17-5-27-8-10-27-7-26 12 2 19 11 33 27 40 19 9 46 15 91 11z", fill "#aa0059" ] [] ]
    , Svg.g [] [ Svg.path [ d "M219 246s-13-7-28-18c-22-15-50-37-62-54-17-23 23-58-16-66-20-4-33 23-25 66 4 21 18 43 39 56 9 6 19 10 28 13 21 6 64 3 64 3z", fill "#f459b2" ] [] ]
    , Svg.g [] [ Svg.path [ d "M185 233c-26-16-52-44-60-62-6-16-3-29 8-37 19-15 39-3 40 10 1 22-19 17-17 28s17 25 27 37c11 12 37 33 37 37s-26-8-35-13z", fill "#ff9bf2" ] [] ]
    ]


rightOuterPetals : List (Svg msg)
rightOuterPetals =
    [ Svg.g [] [ Svg.path [ d "M221 246l50-16c39-13 68-56 82-90 14-33-5-94 35-101 23-4 45 25 33 75-8 36-26 64-53 83-12 9-24 16-35 22-68 38-112 27-112 27z", fill "#c225da" ] [] ]
    , Svg.g [] [ Svg.path [ d "M322 167s12 0 35-5c15-3 34-2 43-21 3-7-6-18 1-30 7-14 30-14 32 8 1 21-7 38-24 49-20 14-45 23-98 27l11-28z", fill "#510f5b" ] [] ]
    , Svg.g [] [ Svg.path [ d "M252 234c19-6 27-7 72-92 13-25 4-69 35-75 17-4 38 11 31 68-2 12-12 49-43 74-55 45-133 37-133 37l38-12z", fill "#da2583" ] [] ]
    , Svg.g [] [ Svg.path [ d "M285 205s14 3 52-6c14-3 33-2 42-21 3-6-6-17 1-30s30-13 32 8c1 21-7 39-24 50-20 13-50 22-103 26v-27z", fill "#9016a3" ] [] ]
    , Svg.g [] [ Svg.path [ d "M258 241s0-13 34-15c12-1 42-6 53-21 3-6-2-17 5-27 8-10 27-7 26 12-2 19-12 33-27 40-19 9-46 15-91 11z", fill "#aa0059" ] [] ]
    , Svg.g [] [ Svg.path [ d "M214 246s13-7 28-18c22-15 50-37 62-54 17-23-23-58 16-66 19-4 33 23 25 66-4 21-19 43-39 56-9 6-19 10-28 13-21 6-64 3-64 3z", fill "#f459b2" ] [] ]
    , Svg.g [] [ Svg.path [ d "M248 233c26-16 52-44 59-62 7-16 4-29-7-37-19-15-39-3-40 10-1 22 19 17 17 28s-17 25-27 37c-11 12-37 33-37 37s26-8 35-13z", fill "#ff9bf2" ] [] ]
    ]


corePetals : List (Svg msg)
corePetals =
    [ Svg.g [] [ Svg.path [ d "M156 83s-5-5-7-12c-3-7-8-18-9-25-2-6-3-14-1-19 1-4 5-8 9-10 3-1 9-1 13 1 4 1 10 5 13 10 3 3 5 9 7 14l3 7c2 7 4 15 4 21 1 4 0 9-1 13 0 5 3 10 0 13s-15 8-20 7-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M143 56c-1-5-9-32 10-36 16-3 25 16 28 23l4 8-6-20c-3-6-7-11-15-14-9-3-17-3-24 6-2 4-3 12-1 22l4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M123 98l-7-12-9-25c-1-6-2-14-1-18 2-5 5-9 9-11 4-1 9-1 13 1 5 2 10 6 14 10l7 14 2 7 5 21-1 13c0 5 3 10 0 13-4 4-16 8-21 7-4 0-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M111 71c-1-5-9-31 9-36 17-3 26 17 28 23l4 8-5-20c-4-6-8-11-15-14-9-2-17-3-24 6-3 4-4 12-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M182 74l-7-12-9-26c-1-6-2-13-1-18 2-5 5-9 9-10 4-2 9-2 13 0 5 2 10 6 14 10l7 14 2 8 5 21-1 13c0 4 3 10 0 13-4 3-16 8-20 7-5-1-7-9-8-12l-4-8z", fill "#cb3bbe" ] [], Svg.path [ d "M170 47c-1-6-9-32 9-36 17-4 26 16 28 22l4 8-5-19c-4-7-8-12-16-14-8-3-17-3-23 5-3 4-4 12-2 23 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M331 105l7-11 11-25c2-6 3-13 2-18s-5-9-8-11c-4-2-9-2-14 0-4 1-10 5-14 9l-7 14-3 6-6 21v14c0 4-4 9-1 12 4 4 15 9 20 9 5-1 7-9 9-12l4-8z", fill "#cb3bbe" ] [], Svg.path [ d "M345 79c1-5 11-31-8-36-16-5-26 14-29 20l-4 8 6-19c4-6 8-11 16-13 9-2 18-2 24 7 2 4 3 12 0 22-1 5-6 15-5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M93 113l-7-12-9-26c-1-5-2-13-1-18 2-4 5-8 9-10 4-1 9-1 13 1 5 1 11 5 14 10l7 14 2 7 5 21-1 13c0 4 3 10 0 13-4 3-16 8-21 7-4-1-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M81 86c-1-5-9-32 9-36 17-3 26 16 28 23l4 8-5-20c-4-6-8-11-15-14-9-3-17-3-24 6-3 4-4 12-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M350 119s5-5 7-12c3-7 8-18 9-25 2-6 2-14 1-18-1-5-5-9-9-11-4-1-9-1-13 1-5 2-10 5-13 10l-7 14-3 7c-2 7-4 15-4 21v13c1 5-2 10 1 13 3 4 15 8 20 7s6-9 8-12l3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M363 92c0-5 8-31-10-36-16-3-26 17-28 23l-4 8 6-20c3-6 7-11 15-14 9-3 17-3 24 6 2 4 3 12 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M281 82s5-6 7-12c3-7 8-18 9-26 2-6 2-13 1-18-1-4-5-8-9-10-3-2-9-1-13 0-5 2-10 6-13 11-3 3-5 8-7 14l-3 7c-2 6-4 15-4 21v13c1 4-2 10 1 13s15 8 20 7 6-9 8-12l3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M294 55c0-5 8-32-10-36-16-4-26 16-28 22l-4 8 6-19c3-6 7-11 15-14 9-3 17-3 24 6 2 3 3 11 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M127 120s-5-5-7-12-8-18-9-25c-2-6-2-14-1-19 1-4 5-8 9-10 4-1 9-1 13 1 5 1 10 5 14 10l6 14 3 7c2 7 4 15 4 21v13c-1 5 3 10-1 13-3 3-15 8-20 7s-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M114 93c0-5-8-32 10-36 16-3 26 16 28 23l4 8-6-20c-3-6-7-11-15-14-9-3-17-3-24 6-2 4-3 12-1 22l4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M152 100l-7-12-9-25c-1-6-2-14-1-18 1-5 5-9 9-11 4-1 9-1 13 1 5 2 10 5 14 10l7 14 2 7 5 21-1 13c0 5 3 10 0 13-4 4-16 8-21 7-4-1-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M140 73c-1-5-9-31 9-36 17-3 26 17 28 23l4 8-6-20c-3-6-7-11-15-14s-17-3-23 6c-3 4-4 12-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M249 73s4-5 6-12l10-25c1-6 2-14 0-18-1-5-5-9-8-11-4-1-10-1-14 1s-10 6-13 10l-7 14-2 7c-3 7-4 15-5 21l1 14c0 4-3 9 0 12 3 4 16 8 20 8 5-1 6-10 8-13l4-8z", fill "#cb3bbe" ] [], Svg.path [ d "M261 47c1-6 9-32-10-36-16-4-25 16-27 22l-4 8 5-20c3-6 7-11 15-13 9-3 17-3 24 5 3 4 3 12 1 22 0 5-4 16-4 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M307 94l7-12c2-7 8-18 9-26 2-5 2-13 1-18-1-4-5-8-9-10s-9-1-13 1c-5 1-10 5-14 10l-7 14-2 7-5 21 1 13c0 4-3 10 0 13 4 3 16 8 21 7 4-1 6-9 8-12l3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M320 67c0-5 8-32-10-36-16-3-26 16-28 23l-4 8 6-20c3-6 7-11 15-14 9-3 17-3 23 6 3 3 4 12 2 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M206 67s-4-7-4-14c-1-7-4-19-4-27 0-6 1-13 4-17 2-4 7-8 11-8 4-1 9 1 13 3 4 3 8 8 10 13l4 15 1 8-1 21c0 5-2 9-4 13-1 4 1 10-3 12-4 3-17 5-21 3-5-2-4-11-5-14l-1-8z", fill "#cb3bbe" ] [], Svg.path [ d "M200 38c0-6-2-33 17-33 17 0 21 21 22 28l2 9-1-21c-1-6-4-12-11-17-8-5-16-6-25 1-3 2-6 10-6 21 0 4 1 16 2 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M316 121s5-6 7-12c2-7 8-18 9-26 2-6 2-13 1-18-1-4-5-8-9-10s-9-1-13 0c-5 2-10 6-14 11l-6 14-3 7c-2 6-4 15-4 21v13c1 4-3 10 1 13 3 3 15 8 20 7s6-9 8-12l3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M329 94c0-5 8-32-10-36-16-4-26 16-28 22l-4 8 6-19c3-6 7-11 15-14 9-3 17-3 24 6 2 3 3 11 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M185 96l-7-12-9-26c-1-6-2-13-1-18 1-4 5-8 9-10s9-1 13 1c5 1 10 5 14 10l7 14 2 7 5 21-1 13c0 4 3 10 0 13-4 3-16 8-21 7-4-1-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M173 69c-1-5-9-32 9-36 16-4 26 16 28 22l4 8-6-19c-3-6-7-11-15-14-9-3-17-3-23 6-3 3-4 11-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M165 117l-7-12-9-25c-1-6-2-14-1-18 2-5 5-9 9-11 4-1 9-1 13 1 5 2 10 6 14 10l7 14 2 7 5 21-1 13c0 5 3 10 0 13-4 4-16 8-21 7-4 0-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M153 90c-1-5-9-31 9-36 17-3 26 17 28 23l4 8-6-20c-3-6-7-11-15-14s-17-3-23 6c-3 4-4 12-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M145 139s-5-6-7-12c-3-7-8-19-9-26-2-6-2-13-1-18 1-4 5-8 9-10 3-2 9-1 13 0 4 2 10 6 13 11 3 3 5 8 7 14l3 7c2 6 4 15 4 21 1 4 0 9-1 13 0 4 3 10 0 13s-15 8-20 7-6-9-8-13l-3-7z", fill "#cb3bbe" ] [], Svg.path [ d "M132 112c0-5-9-32 10-36 16-4 26 16 28 22l4 8-6-19c-3-6-7-11-15-14-9-3-17-3-24 6-2 3-3 11-1 22l4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M123 150s-5-6-7-13c-3-6-8-18-9-25-2-6-3-13-1-18 1-4 5-9 9-10 3-2 9-2 13 0s10 6 13 10l7 14 3 7 4 21c1 5 0 9-1 14 0 4 3 9 0 12-3 4-15 9-20 8s-6-9-8-13l-3-7z", fill "#cb3bbe" ] [], Svg.path [ d "M110 123c-1-6-9-32 10-36 16-4 25 16 28 22l4 8-6-19c-3-7-7-12-15-14-9-3-17-3-24 6-2 3-3 11-1 21l4 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M274 98s5-6 7-12c3-7 8-18 10-26 1-6 2-13 0-18-1-4-5-8-8-10-4-2-10-1-14 0-4 2-10 6-13 11-3 3-5 8-7 14l-3 7-4 21c-1 4 1 9 1 13s-3 10 0 13 16 8 20 7c5-1 6-9 8-13 2-2 3-7 3-7z", fill "#cb3bbe" ] [], Svg.path [ d "M287 71c1-5 9-32-10-36-16-4-25 16-28 22l-4 8 6-19c3-6 7-11 15-14 9-3 17-3 24 6 3 3 3 11 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M246 95l7-13 9-25c1-6 2-13 1-18-2-4-6-9-9-10-4-2-9-1-14 0-4 2-10 6-13 10l-7 14-2 7c-3 7-4 16-5 21l1 14c0 4-3 10 0 13 4 3 16 8 20 7 5-1 7-9 8-13l4-7z", fill "#cb3bbe" ] [], Svg.path [ d "M258 68c1-6 9-32-10-36-16-4-25 16-27 22l-4 8 5-19c3-7 8-12 15-14 9-3 17-3 24 6 3 3 4 11 2 21-1 5-5 16-5 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M205 94s-3-6-4-13l-3-27c0-6 1-14 3-18s7-7 11-8 9 1 13 4c4 2 8 7 11 13l3 15 1 7v22l-4 12c-1 5 0 11-3 13-4 2-17 4-22 2-4-2-4-10-5-14l-1-8z", fill "#cb3bbe" ] [], Svg.path [ d "M199 65c0-5-1-33 18-33 16 0 21 22 21 28 1 3 2 11 3 9l-1-20c-2-7-5-13-12-17-8-5-16-7-24 0-4 3-6 11-7 21 0 4 1 16 2 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M195 123s-3-6-4-13l-3-27c0-6 1-14 3-18s7-7 11-8 9 1 13 4c4 2 9 7 11 13l3 15 1 7v22l-4 13c-1 4 0 10-3 12-4 2-17 4-22 2-4-2-4-10-5-14l-1-8z", fill "#cb3bbe" ] [], Svg.path [ d "M189 94c0-5-1-33 18-33 16 1 21 22 21 29 1 3 2 10 3 8l-1-20c-2-7-5-13-12-17-8-5-16-7-24 0-4 3-6 11-7 21 0 5 1 16 2 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M189 153l-7-12-9-25c-1-6-2-14 0-18 1-5 5-9 8-11 4-1 10-1 14 1s10 6 13 10l7 14 2 7c3 7 4 15 5 21l-1 14c0 4 3 9 0 12-3 4-16 8-20 8-5-1-6-10-8-13l-4-8z", fill "#cb3bbe" ] [], Svg.path [ d "M177 127c-1-6-9-32 10-37 16-3 25 17 27 23l4 8-5-20c-3-6-7-11-15-14-9-2-17-3-24 6-3 4-4 12-1 22 0 4 4 15 4 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M284 116s5-5 7-12l10-25c1-6 2-13 0-18-1-5-5-9-9-10-3-2-9-2-13 0s-10 6-13 10l-7 14-3 7c-2 7-4 15-4 21-1 5 1 9 1 14 0 4-3 9 0 12 3 4 15 8 20 8 5-1 6-10 8-13l3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M297 90c1-6 9-32-10-36-16-4-25 16-28 22l-4 8c1-2 4-16 6-19 3-7 7-12 15-14 9-3 17-3 24 5 3 4 3 12 1 22l-4 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M248 124s5-6 7-13l10-25c1-6 2-13 0-18-1-4-5-9-9-10-3-2-9-1-13 0-4 2-10 6-13 10l-7 14-3 8-4 20c-1 5 0 9 1 14 0 4-3 10 0 13s15 8 20 7 6-9 8-13l3-7z", fill "#cb3bbe" ] [], Svg.path [ d "M261 97c1-6 9-32-10-36-16-4-25 16-28 22l-4 8 6-19c3-7 7-12 15-14 9-3 17-3 24 6 3 3 3 11 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M209 150l-4-14-3-27c0-6 1-13 3-18 2-3 7-7 11-8 4 0 9 2 13 4 4 3 8 8 11 13l3 15 1 8-1 21-3 13c-2 4 0 10-4 12-4 3-17 5-21 3s-4-11-5-14l-1-8z", fill "#cb3bbe" ] [], Svg.path [ d "M203 121c0-6-2-34 17-33 17 0 22 21 22 28l2 9c1-2 0-16-1-21-1-7-4-12-11-17-8-5-16-7-25 1-3 2-6 10-6 21 0 4 1 16 2 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M258 156s4-5 6-12l10-25c1-6 2-14 0-18-1-5-5-9-8-11-4-1-10-1-14 1s-10 6-13 10l-7 14-2 7c-3 7-4 15-5 21l1 14c0 4-3 9 0 12 3 4 16 8 20 8 5-1 6-10 8-13l4-8z", fill "#cb3bbe" ] [], Svg.path [ d "M270 130c1-6 9-32-10-36-16-4-25 16-27 22l-4 8 5-20c3-6 7-11 15-13 9-3 17-3 24 5 3 4 3 12 1 22 0 5-4 16-4 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M296 148s5-6 7-13c3-6 8-18 9-25 2-6 3-13 1-18-1-4-5-9-9-10-3-2-9-1-13 0-4 2-10 6-13 10l-7 14-3 7-4 21c-1 5 0 9 1 14 0 4-3 10 0 13s15 8 20 7 6-9 8-13l3-7z", fill "#cb3bbe" ] [], Svg.path [ d "M309 121c1-6 9-32-10-36-16-4-25 16-28 22l-4 8 6-19c3-7 7-12 15-14 9-3 17-3 24 6 2 3 3 11 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M314 177s5-5 7-12c3-7 8-18 9-25 2-6 2-14 1-18-1-5-5-9-9-11-4-1-9-1-13 1-5 2-10 5-13 10l-7 14-3 7c-2 7-4 15-4 21v13c1 5-2 10 1 13 3 4 15 8 20 7 5 0 6-9 8-12l3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M327 150c0-5 8-31-10-36-16-3-26 17-28 23l-4 8 6-20c3-6 7-11 15-14 9-3 17-3 24 6 2 4 3 12 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M168 173l-7-13-9-25c-1-6-2-13-1-18 1-4 5-9 9-10 4-2 9-1 13 0 5 2 10 6 14 10l7 14 2 7 5 21-1 14c0 4 3 10 0 13-4 3-16 8-21 7-4-1-6-9-8-13l-3-7z", fill "#cb3bbe" ] [], Svg.path [ d "M156 146c-1-6-9-32 9-36 17-4 26 16 28 22l4 8-6-19c-3-7-7-12-15-14-8-3-17-3-23 6-3 3-4 11-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M133 180l-7-13-9-25c-1-6-2-13-1-18 2-4 6-9 9-10 4-2 9-2 14 0 4 2 10 6 13 10l7 14 2 7c3 7 4 16 5 21l-1 14c0 4 3 9 0 12-4 4-16 9-20 8-5-1-7-9-8-13l-4-7z", fill "#cb3bbe" ] [], Svg.path [ d "M121 153c-1-6-9-32 10-36 16-4 25 16 27 22l4 8-5-19c-3-7-8-12-15-14-9-3-17-3-24 6-3 3-4 11-2 21 1 5 5 16 5 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M277 177l7-12 9-25c1-6 2-14 0-18-1-5-5-9-8-11-4-1-10-1-14 1s-10 5-13 10l-7 14-2 7c-3 7-4 15-5 21l1 13c0 5-3 10 0 13 4 4 16 8 20 7 5-1 6-9 8-12l4-8z", fill "#cb3bbe" ] [], Svg.path [ d "M289 150c1-5 9-31-10-36-16-3-25 17-27 23l-4 8 5-20c3-6 7-11 15-14 9-3 17-3 24 6 3 4 4 12 1 22 0 4-4 15-4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M144 218s-5-6-7-12l-10-26c-1-6-2-13 0-18 1-4 5-8 8-10 4-2 10-1 14 0 4 2 10 6 13 11 3 3 5 8 7 14l3 7 4 21c1 4 3 11-1 13-5 2-31 0-31 0z", fill "#cb3bbe" ] [], Svg.path [ d "M131 191c-1-5-9-32 10-36 16-4 25 16 28 22l4 8-6-19c-3-6-7-11-15-14-9-3-17-3-24 6-3 3-3 11-1 22l4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M194 186l-7-13-9-25c-1-6-2-13-1-18 2-4 6-9 9-10 4-2 9-1 13 0 5 2 11 6 14 10l7 14 2 7 5 21-1 14c0 4 3 10 0 13-4 3-16 8-21 7-4-1-6-9-7-13l-4-7z", fill "#cb3bbe" ] [], Svg.path [ d "M182 159c-1-6-9-32 10-36 16-4 25 16 27 22l4 8-5-19c-3-7-8-12-15-14-9-3-17-3-24 6-3 3-4 11-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M221 209c8-5 19-30 22-37l9-25c1-6 2-14 1-18-2-5-6-9-9-11-4-1-9-1-14 1-4 2-10 6-13 10l-7 14-2 7c-3 7-15 51-13 55 4 10 18 9 26 4z", fill "#cb3bbe" ] [], Svg.path [ d "M248 158c1-6 9-32-10-36-16-4-25 16-27 22l-4 8 5-20c3-6 8-11 15-13 9-3 17-4 24 5 3 4 4 12 2 22-1 5-5 16-5 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M206 242c8-6 19-30 22-37l9-25c1-6 2-14 1-18-2-5-5-9-9-11-4-1-9-1-13 1-5 2-10 6-14 10l-7 14-2 7c-2 7-15 51-13 55 4 10 19 9 26 4z", fill "#cb3bbe" ] [], Svg.path [ d "M233 191c1-6 9-32-9-37-17-3-26 17-28 23l-4 8 5-20c4-6 8-11 15-14 9-2 18-3 24 6 3 4 4 12 2 22-1 5-5 15-5 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M170 220s-5-5-7-12l-10-25c-1-6-2-14 0-18 1-5 5-9 8-11 4-1 10-1 14 1s10 5 13 10l7 14 2 7c3 7 4 15 5 21 1 4-1 9-1 13 0 5 3 10 0 13-3 4-16 8-20 7-5 0-6-9-8-12l-3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M157 193c-1-5-9-31 10-36 16-3 25 17 27 23l4 8-5-20c-3-6-7-11-15-14-9-3-17-3-24 6-3 4-3 12-1 22 0 4 5 15 4 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M265 218s5-5 7-12c3-7 8-18 9-25 2-6 2-13 1-18s-5-9-9-10c-4-2-9-2-13 0-5 2-10 6-14 10l-6 14-3 7c-2 7-4 15-4 21v14c1 4-2 9 1 12 3 4 15 9 20 8s6-10 8-13l3-8z", fill "#cb3bbe" ] [], Svg.path [ d "M278 192c0-6 8-32-10-36-16-4-26 16-28 22l-4 8c0-2 4-16 6-19 3-7 7-12 15-14 9-3 17-3 24 5 2 4 3 12 1 22l-4 12z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M191 243l-16-32c-2-6-2-13-1-18 2-4 5-9 9-10 4-2 9-1 13 0 5 2 10 6 14 10l7 14 2 8 5 29-33-1z", fill "#cb3bbe" ] [], Svg.path [ d "M179 222c-1-6-9-32 9-36 17-4 26 16 28 22l4 8-5-19c-4-7-8-12-15-14-9-3-17-3-24 6-3 3-4 11-2 22 1 4 5 15 5 11z", fill "#ef9dcc" ] [] ]
    , Svg.g [] [ Svg.path [ d "M205 243l39 1s8-21 9-29c2-5 2-13 1-18-1-4-5-8-9-10-4-1-9-1-13 1-5 1-10 5-14 10l-6 14-3 7-4 24z", fill "#cb3bbe" ] [], Svg.path [ d "M250 226c0-5 8-32-10-36-16-3-26 16-28 23l-4 8 6-20c3-6 7-11 15-14 9-3 17-3 24 6 2 4 3 12 1 22l-4 11z", fill "#ef9dcc" ] [] ]
    ]
