import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: instruments_rooms
        active: false
        parentStream: audio_stream
        configuration: rooms_config
        exposePath: "/audio/instruments/rooms"

        WPN114.RoomSource
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/instruments/kaivo-1/spatialization"

            WPN114.AudioPlugin
            {
                id: kaivo_1
                active: false
                path: "Kaivo.vst"
                exposePath: "/audio/instruments/kaivo-1"

                WPN114.Fork { target: altiverb; leveldB: -6.0
                    exposePath: "/audio/instruments/kaivo-1/sends/altiverb" }

                WPN114.Fork { target: amplitube; leveldB: -6.0; active: false
                    exposePath: "/audio/instruments/kaivo-1/sends/amplitube"
            }
        }

        WPN114.RoomSource
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/instruments/kaivo-2/spatialization"

            WPN114.AudioPlugin
            {
                id: kaivo_2
                active: false
                path: "Kaivo.vst"
                exposePath: "/audio/instruments/kaivo-2"

                WPN114.Fork { target: altiverb; leveldB: -6.0
                    exposePath: "/audio/instruments/kaivo-2/sends/altiverb" }

                WPN114.Fork { target: amplitube; leveldB: -6.0; active: false
                    exposePath: "/audio/instruments/kaivo-2/sends/amplitube"
            }
        }

        WPN114.RoomSource
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/instruments/absynth/spatialization"

            WPN114.AudioPlugin
            {
                id: absynth
                active: false
                path: "Absynth 5.vst"
                exposePath: "/audio/instruments/absynth"

                WPN114.Fork { target: altiverb; leveldB: -6.0
                    exposePath: "/audio/instruments/absynth/sends/altiverb" }

                WPN114.Fork { target: amplitube; leveldB: -6.0; active: false
                    exposePath: "/audio/instruments/absynth/sends/amplitube"
            }
        }

        WPN114.RoomSource
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/instruments/altiverb/spatialization"

            WPN114.AudioPlugin
            {
                id: altiverb
                active: true
                path: "Altiverb 7.vst"
                exposePath: "/audio/instruments/altiverb"
            }
        }

        WPN114.RoomSource
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/instruments/amplitube/spatialization"

            WPN114.AudioPlugin
            {
                id: amplitube
                active: false
                path: "Amplitube 4.vst"
                exposePath: "/audio/instruments/amplitube"
            }
        }
    }

}
