import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: ammon_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        WPN114.StereoSource //----------------------------------------- 1.FOOTSTEPS (1-2)
        {            
            fixed: true
            xspread: 0.3
            diffuse: 0.1
            y: 0.1

            exposePath: "/audio/stonepath/ammon/footsteps/source"

            WPN114.Sampler { id: footsteps;
                exposePath: "/audio/stonepath/ammon/footsteps"
                path: "audio/stonepath/ammon/foosteps.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.BROKEN-RADIO (3-4)
        {
            fixed: true
            xspread: 0.05
            y: 0.8

            exposePath: "/audio/stonepath/ammon/broken-radio/source"

            WPN114.Sampler { id: broken_radio;
                exposePath: "/audio/stonepath/ammon/broken-radio"
                path: "audio/stonepath/ammon/broken-radio.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.HARMONICS (5-6)
        {
            fixed: true
            xspread: 0.3
            diffuse: 0.3
            y: 0.75

            exposePath: "/audio/stonepath/ammon/harmonics/source"

            WPN114.StreamSampler { id: harmonics;
                exposePath: "/audio/stonepath/ammon/harmonics"
                path: "audio/stonepath/ammon/harmonics.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.WIND (7-8)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.85

            exposePath: "/audio/stonepath/ammon/wind/source"

            WPN114.Sampler { id: wind;
                exposePath: "/audio/stonepath/ammon/wind"
                path: "audio/stonepath/ammon/wind.wav" }
        }
    }
}
