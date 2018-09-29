import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: diaclases_rooms
        active: false
        parentStream: audio_stream
        configuration: rooms_config

        exposePath: "/audio/stone-path/diaclases/rooms"

        WPN114.RoomSource //----------------------------------------- 1.STONEWATER (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/diaclases/stonewater/spatialization"

            WPN114.Sampler { id: stonewater; stream: true;
                exposePath: "/audio/stone-path/diaclases/stonewater"
                path: "audio/stone-path/diaclases/stonewater.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.HARMONICS (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/diaclases/harmonics/spatialization"

            WPN114.Sampler { id: harmonics; stream: true;
                exposePath: "/audio/stone-path/diaclases/harmonics"
                path: "audio/stone-path/diaclases/harmonics.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.DRONE (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/diaclases/drone/spatialization"

            WPN114.Sampler { id: drone; stream: true;
                exposePath: "/audio/stone-path/diaclases/drone"
                path: "audio/stone-path/diaclases/drone.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.SMOKE (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/diaclases/smoke/spatialization"

            WPN114.Sampler { id: smoke; stream: true;
                exposePath: "/audio/stone-path/diaclases/smoke"
                path: "audio/stone-path/diaclases/smoke.wav" }
        }
    }

}
