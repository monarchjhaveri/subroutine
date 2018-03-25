module Main exposing (..)

import Html exposing (..)


-- MSG


type Msg
    = NoOp



-- MODEL


type alias Model =
    { room : List Cell
    , player : Player
    }


type alias X =
    Int


type alias Y =
    Int


type Cell
    = Floor X Y
    | Wall X Y


type alias Player =
    { x : Int
    , y : Int
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    text "Hello World"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


init : ( Model, Cmd Msg )
init =
    ( (Model [] (Player 0 0)), Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }
