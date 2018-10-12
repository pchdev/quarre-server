import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: markhor_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/audio/stonepath/markhor/rooms"

        WPN114.StereoSource //----------------------------------------- 1.DOOMSDAY (1-2)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.55

            exposePath: "/audio/stonepath/markhor/doomsday/source"

            WPN114.MultiSampler { id: doomsday;
                exposePath: "/audio/stonepath/markhor/doomsday"
                path: "audio/stonepath/markhor/doomsday" }
        }

        WPN114.StereoSource //----------------------------------------- 2.AMBIENT-LIGHT (3-4)
        {
            fixed: true
            xspread: 0.15
            diffuse: 0.3
            y: 0.85

            exposePath: "/audio/stonepath/markhor/ambient-light/source"

            WPN114.Sampler { id: ambient_light;
                exposePath: "/audio/stonepath/markhor/ambient-light"
                path: "audio/stonepath/markhor/ambient-light.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.PARORAL (5-6)
        {
            fixed: true
            xspread: 0.35
            diffuse: 0.65
            y: 0.7

            exposePath: "/audio/stonepath/markhor/paroral/source"

            WPN114.Sampler { id: paroral;
                exposePath: "/audio/stonepath/markhor/paroral"
                path: "audio/stonepath/markhor/paroral.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.SOUNDSCAPE (7-8)
        {
            fixed: true
            xspread: 0.25
            diffuse: 1.0
            y: 0.4

            exposePath: "/audio/stonepath/markhor/soundscape/source"

            WPN114.Sampler { id: soundscape;
                exposePath: "/audio/stonepath/markhor/soundscape"
                path: "audio/stonepath/markhor/soundscape.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.BELL_HIT (9-10)
        {
            fixed: true
            xspread: 0.05
            diffuse: 0.2
            y: 0.55

            exposePath: "/audio/stonepath/markhor/bell-hit/source"

            WPN114.Sampler { id: bell_hit;
                exposePath: "/audio/stonepath/markhor/bell-hit"
                path: "audio/stonepath/markhor/bell-hit.wav" }
        }
    }

}
