import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property alias reverb:      reverb
    property alias amplitube:   amplitube
    property alias rooms:       effects_rooms

    WPN114.Rooms
    {
        id: effects_rooms
        active: true
        parentStream: audio_stream
        setup: rooms_setup
        exposePath: "/effects/rooms"

        WPN114.StereoSource //----------------------------------------------------- ALTIVERB
        {
            active: true
            xspread: 0.25
            diffuse: 0.55
            y: 0.5

            exposePath: "/effects/reverb/source"

            WPN114.Convolver
            {
                id: reverb
                irPath: "/Users/pchd/Desktop/IRS/921.wav"
                exposePath: "/effects/reverb"
            }
        }

        WPN114.StereoSource //----------------------------------------------------- AMPLITUBE
        {
            active: false
            xspread: 0.25
            diffuse: 0.55
            y: 0.5

            exposePath: "/effects/amplitube/source"

            WPN114.AudioPlugin // TODO: switch to convolver
            {
                id: amplitube
                path: "/Library/Audio/Plug-Ins/VST/Amplitube 4.vst"
                exposePath: "/effects/amplitube"
            }
        }
    }
}
