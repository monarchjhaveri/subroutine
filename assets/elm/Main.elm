module Main exposing (..)

import Html exposing (..)


-- MSG


type Msg
    = NoOp



-- MODEL
-- UPDATE
-- VIEW


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }
