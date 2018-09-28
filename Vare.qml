import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: vare_rooms
        active: false
        parentStream: audio_stream
        configuration: rooms_config

        WPN114.RoomSource //----------------------------------------- 1.SNOWFALL (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/vare/snowfall/spatialization"

            WPN114.Sampler { id: snowfall; stream: true;
                exposePath: "/audio/wood-path/vare/snowfall"
                path: "audio/wood-path/vare/snowfall.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.HAMMER (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/vare/hammer/spatialization"

            WPN114.Sampler { id: hammer; stream: true;
                exposePath: "/audio/wood-path/vare/hammer"
                path: "audio/wood-path/vare/hammer.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.PARORAL (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/vare/paroral/spatialization"

            WPN114.Sampler { id: paroral; stream: true;
                exposePath: "/audio/wood-path/vare/paroral"
                path: "audio/wood-path/vare/paroral.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.DOOMSDAY (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/vare/doomsday/spatialization"

            WPN114.Sampler { id: doomsday; stream: true;
                exposePath: "/audio/wood-path/vare/doomsday"
                path: "audio/wood-path/vare/doomsday.wav" }
        }
    }
}
