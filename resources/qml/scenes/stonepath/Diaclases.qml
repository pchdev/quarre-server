import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: diaclases_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/audio/stonepath/diaclases/rooms"

        WPN114.StereoSource //----------------------------------------- 1.STONEWATER (1-2)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.5
            y: 0.25

            exposePath: "/audio/stonepath/diaclases/stonewater/source"

            WPN114.StreamSampler { id: stonewater;
                exposePath: "/audio/stonepath/diaclases/stonewater"
                path: "audio/stonepath/diaclases/stonewater.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.HARMONICS (3-4)
        {            
            fixed: true
            xspread: 0.25
            diffuse: 0.5
            y: 0.25

            exposePath: "/audio/stonepath/diaclases/harmonics/source"

            WPN114.StreamSampler { id: harmonics;
                exposePath: "/audio/stonepath/diaclases/harmonics"
                path: "audio/stonepath/diaclases/harmonics.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.DRONE (5-6)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.6
            y: 0.85

            exposePath: "/audio/stonepath/diaclases/drone/source"

            WPN114.StreamSampler { id: drone;
                exposePath: "/audio/stonepath/diaclases/drone"
                path: "audio/stonepath/diaclases/drone.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 4.SMOKE (7-8)
        {
            exposePath: "/audio/stonepath/diaclases/smoke/source"

            WPN114.Sampler { id: smoke;
                exposePath: "/audio/stonepath/diaclases/smoke"
                path: "audio/stonepath/diaclases/smoke.wav" }
        }
    }
}
