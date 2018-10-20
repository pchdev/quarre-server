import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{

    WPN114.Node
    {
        type: WPN114.Type.Bool
        path: "audio/stonepath/deidarabotchi/play"
        onValueReceived:
        {
            deidarabotchi_rooms.active = newValue;
            kaivo.active = newValue;
            synth.active = newValue;
            background.active = newValue;
            breath.active = newValue;
            wind.wactive = newValue;
        }
    }

    WPN114.Rooms
    {
        id: deidarabotchi_rooms
        parentStream: audio_stream
        setup: rooms_setup
        active: false

        exposePath: "/stonepath/deidarabotchi/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.KAIVO (1-2)
        {
            fixed: true
            xspread: 0.2
            diffuse: 0.55
            y: 0.55

            exposePath: "/stonepath/deidarabotchi/audio/kaivo/source"

            WPN114.StreamSampler { id: kaivo;
                exposePath: "/stonepath/deidarabotchi/audio/kaivo"
                path: "audio/stonepath/deidarabotchi/kaivo.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.SYNTH (3-4)
        {
            fixed: true
            xspread: 0.15
            diffuse: 0.3
            y: 0.9

            exposePath: "/stonepath/deidarabotchi/audio/synth/source"

            WPN114.StreamSampler { id: synth;
                exposePath: "/stonepath/deidarabotchi/audio/synth"
                path: "audio/stonepath/deidarabotchi/synth.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.BACKGROUND (5-6)
        {            
            fixed: true
            xspread: 0.35
            diffuse: 0.9

            exposePath: "/stonepath/deidarabotchi/audio/background/source"

            WPN114.StreamSampler { id: background;
                exposePath: "/stonepath/deidarabotchi/audio/background"
                path: "audio/stonepath/deidarabotchi/background.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.BREATH (7-8)
        {
            fixed: true
            xspread: 0.1
            diffuse: 0.25
            y: 0.55

            exposePath: "/stonepath/deidarabotchi/audio/breath/source"

            WPN114.StreamSampler { id: breath;
                exposePath: "/stonepath/deidarabotchi/audio/breath"
                path: "audio/stonepath/deidarabotchi/breath.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.WIND (9-10)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.5
            y: 0.25

            exposePath: "/stonepath/deidarabotchi/audio/wind/source"

            WPN114.StreamSampler { id: wind;
                exposePath: "/stonepath/deidarabotchi/audio/wind"
                path: "audio/stonepath/deidarabotchi/wind.wav" }
        }
    }
}
