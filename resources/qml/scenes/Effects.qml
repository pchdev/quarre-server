import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property alias reverb:      reverb
    property alias lavaur:      reverb_lavaur
    property alias amplitube:   amplitube
    property alias rooms:       effects_rooms

    WPN114.Rooms
    {
        id: effects_rooms
        active: true
        parentStream: audiostream
        setup: roomsetup
        exposePath: "/scenario/effects/rooms"

        WPN114.StereoSource //----------------------------------------------------- ALTIVERB
        {
            xspread: 0.25
            diffuse: 0.2
            fixed: true
            y: 0.5
            z: 0.4

            exposePath: "/scenario/effects/reverb/source"

            WPN114.Convolver //============================================== 921
            {                
                id: reverb
                active: true
                irPath: "audio/impulse-responses/921MST.wav"
                exposePath: "/scenario/effects/reverb/921"
            }

            WPN114.Convolver //============================================== LAVAUR
            {
                id: reverb_lavaur
                active: false
                irPath: "audio/impulse-responses/LAVAUR22ST.wav"
                exposePath: "/scenario/effects/reverb/lavaur"
            }

            WPN114.Convolver //============================================== AMPLITUBE
            {
                id: amplitube
                active: false
                irPath: "audio/impulse-responses/AMPDEFAULT.wav"
                exposePath: "/scenario/effects/amplitube"
            }
        }
    }
}
