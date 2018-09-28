import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: ammon_rooms
        active: false
        parentStream: audio_stream
        configuration: rooms_config

        WPN114.RoomSource //----------------------------------------- 1.FOOTSTEPS (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/ammon/footsteps/spatialization"

            WPN114.Sampler { id: footsteps; stream: true;
                exposePath: "/audio/stone-path/ammon/footsteps"
                path: "audio/stone-path/ammon/foosteps.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.BROKEN-RADIO (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/ammon/broken-radio/spatialization"

            WPN114.Sampler { id: broken_radio; stream: true;
                exposePath: "/audio/stone-path/ammon/broken-radio"
                path: "audio/stone-path/ammon/broken-radio.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.HARMONICS (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/ammon/harmonics/spatialization"

            WPN114.Sampler { id: harmonics; stream: true;
                exposePath: "/audio/stone-path/ammon/harmonics"
                path: "audio/stone-path/ammon/harmonics.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.WIND (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/ammon/wind/spatialization"

            WPN114.Sampler { id: wind; stream: true;
                exposePath: "/audio/stone-path/ammon/wind"
                path: "audio/stone-path/ammon/wind.wav" }
        }
    }
}
