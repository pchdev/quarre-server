import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{

    WPN114.Node
    {
        type: WPN114.Type.Bool
        path: "audio/stone-path/deidarabotchi/play"
        onValueReceived:
        {
            deidarabotchi_rooms.active = newValue;
            kaivo.active = newValue;
            synth.active = newValue;
            background.active = newValue;
            breath.active = newValue;
            wind.wactive = newValue;
        }
    }

    WPN114.Rooms
    {
        id: deidarabotchi_rooms
        parentStream: audio_stream
        configuration: rooms_config
        active: false

        exposePath: "/audio/stone-path/deidarabotchi/rooms"

        WPN114.RoomSource //----------------------------------------- 1.KAIVO (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/deidarabotchi/kaivo"

            WPN114.Sampler { id: kaivo; stream: true;
                path: "audio/stone-path/deidarabotchi/kaivo.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.SYNTH (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/deidarabotchi/synth"

            WPN114.Sampler { id: synth; stream: true;
                path: "audio/stone-path/deidarabotchi/synth.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.BACKGROUND (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/deidarabotchi/background"

            WPN114.Sampler { id: background; stream: true;
                path: "audio/stone-path/deidarabotchi/background.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.BREATH (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/deidarabotchi/breath"

            WPN114.Sampler { id: breath; stream: true;
                path: "audio/stone-path/deidarabotchi/breath.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.WIND (9-10)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/deidarabotchi/wind"

            WPN114.Sampler { id: wind; stream: true;
                path: "audio/stone-path/deidarabotchi/wind.wav" }
        }
    }
}
