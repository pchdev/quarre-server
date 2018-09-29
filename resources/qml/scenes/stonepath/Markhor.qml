import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: markhor_rooms
        active: false
        parentStream: audio_stream
        configuration: rooms_config

        WPN114.RoomSource //----------------------------------------- 1.DOOMSDAY (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/markhor/doomsday/spatialization"

            WPN114.Sampler { id: doomsday; stream: true;
                exposePath: "/audio/stone-path/markhor/doomsday"
                path: "audio/stone-path/markhor/doomsday.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.AMBIENT-LIGHT (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/markhor/ambient-light/spatialization"

            WPN114.Sampler { id: ambient_light; stream: true;
                exposePath: "/audio/stone-path/markhor/ambient-light"
                path: "audio/stone-path/markhor/ambient-light.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.PARORAL (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/markhor/paroral/spatialization"

            WPN114.Sampler { id: paroral; stream: true;
                exposePath: "/audio/stone-path/markhor/paroral"
                path: "audio/stone-path/markhor/paroral.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.SOUNDSCAPE (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/markhor/soundscape/spatialization"

            WPN114.Sampler { id: soundscape; stream: true;
                exposePath: "/audio/stone-path/markhor/soundscape"
                path: "audio/stone-path/markhor/soundscape.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.BELL_HIT (9-10)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/markhor/bell-hit/spatialization"

            WPN114.Sampler { id: bell_hit; stream: true;
                exposePath: "/audio/stone-path/markhor/bell-hit"
                path: "audio/stone-path/markhor/bell-hit.wav" }
        }
    }

}
