module Main exposing (..)

import Html exposing (..)


-- MSG


type Msg
    = NoOp



-- MODEL


type alias Model =
    {}



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }
