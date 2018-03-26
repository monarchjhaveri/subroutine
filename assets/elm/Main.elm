module Main exposing (..)

import Html exposing (..)
import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import List.Extra


-- MSG


type Msg
    = GetState
    | NewState (Result Http.Error GameData)



-- MODEL


type alias Model =
    { data : GameData
    , err : Error
    }


type alias GameData =
    { room : List Cell
    , roomSize : Int
    , player : Player
    }


type alias X =
    Int


type alias Y =
    Int


type alias Cell =
    { x : X
    , y : Y
    , cellType : String
    }


type alias Player =
    { x : Int
    , y : Int
    }


type Error
    = None
    | FetchFail



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetState ->
            ( model, getServerState )

        NewState (Ok data) ->
            ( { model | data = { data | roomSize = data.roomSize + 1 } }, Cmd.none )

        NewState (Err _) ->
            ( { model | err = FetchFail }, Cmd.none )


getServerState : Cmd Msg
getServerState =
    let
        url =
            "/api"

        request =
            Http.get url decodeServerState
    in
        Http.send NewState request


decodeServerState : Decoder GameData
decodeServerState =
    decode GameData
        |> required "room" (list cellDecoder)
        |> required "size" int
        |> required "player" playerDecoder


cellDecoder : Decoder Cell
cellDecoder =
    decode Cell
        |> required "x" int
        |> required "y" int
        |> required "type" string


playerDecoder : Decoder Player
playerDecoder =
    decode Player
        |> required "x" int
        |> required "y" int



-- VIEW


view : Model -> Html Msg
view model =
    case model.err of
        None ->
            code [] (intersperseEvery (List.map viewCell model.data.room) model.data.roomSize (br [] []))

        FetchFail ->
            text "failed to fetch from server"


intersperseEvery : List a -> Int -> a -> List a
intersperseEvery list count elem =
    let
        broken =
            List.Extra.greedyGroupsOf count list

        interspersed =
            List.intersperse [ elem ] broken
    in
        List.concat interspersed


viewCell : Cell -> Html Msg
viewCell cell =
    case cell.cellType of
        "FLOOR" ->
            text "."

        "WALL" ->
            text "#"

        _ ->
            text "!"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


init : ( Model, Cmd Msg )
init =
    ( (Model (GameData [] 0 (Player 0 0)) None), getServerState )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }
