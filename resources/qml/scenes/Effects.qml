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
        parentStream: audio_stream
        setup: rooms_setup
        exposePath: "/effects/rooms"

        WPN114.StereoSource //----------------------------------------------------- ALTIVERB
        {
            xspread: 0.25
            diffuse: 0.55
            fixed: true

            y: 0.5

            exposePath: "/effects/reverb/source"

            WPN114.Convolver
            {                
                id: reverb
                active: true
                irPath: "/Users/pchd/Desktop/IRS/921MST.wav"
                exposePath: "/effects/reverb/921"
            }

            WPN114.Convolver
            {
                id: reverb_lavaur
                active: false
                irPath: "/Users/pchd/Desktop/IRS/LAVAUR22ST.wav"
                exposePath: "/effects/reverb/lavaur"
            }

            WPN114.Convolver
            {
                id: amplitube
                active: false
                irPath: "/Users/pchd/Desktop/IRS/AMPDEFAULT.wav"
                exposePath: "/effects/amplitube"
            }
        }
    }
}
