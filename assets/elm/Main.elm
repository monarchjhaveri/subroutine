module Main exposing (..)

import Html exposing (..)
import Html.Attributes as Attributes
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
    , player : PlayerLocation
    }


type alias X =
    Int


type alias Y =
    Int


type alias Cell =
    { x : X
    , y : Y
    , cellType : CellT
    }


type CellT
    = Floor
    | Wall
    | Player
    | Unknown String


type alias PlayerLocation =
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
            ( { model
                | data =
                    { data
                        | roomSize = data.roomSize + 1
                        , room = List.map (insertPlayer data.player) data.room
                    }
              }
            , Cmd.none
            )

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
        |> required "type" (string |> andThen cellTDecoder)


cellTDecoder : String -> Decoder CellT
cellTDecoder str =
    case str of
        "FLOOR" ->
            succeed Floor

        "WALL" ->
            succeed Wall

        n ->
            succeed (Unknown n)


playerDecoder : Decoder PlayerLocation
playerDecoder =
    decode PlayerLocation
        |> required "x" int
        |> required "y" int



-- VIEW


view : Model -> Html Msg
view model =
    case model.err of
        None ->
            let
                room =
                    List.map viewCell model.data.room
            in
                code [] (intersperseEvery model.data.roomSize (br [] []) room)

        FetchFail ->
            text "failed to fetch from server"


intersperseEvery : Int -> a -> List a -> List a
intersperseEvery count elem list =
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
        Floor ->
            text "."

        Wall ->
            text "#"

        Player ->
            text "@"

        Unknown str ->
            span [ Attributes.title str ] [ text "!" ]


insertPlayer : PlayerLocation -> Cell -> Cell
insertPlayer player cell =
    if cell.x == player.x && cell.y == player.y then
        { cell | cellType = Player }
    else
        cell



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


init : ( Model, Cmd Msg )
init =
    ( (Model (GameData [] 0 (PlayerLocation 0 0)) None), getServerState )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }
