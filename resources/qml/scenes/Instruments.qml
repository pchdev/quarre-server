import QtQuick 2.10
import WPN114 1.0 as WPN114

Item
{
    id: root
    property alias rooms: instruments_rooms
    property alias kaivo_1: kaivo_1
    property alias kaivo_2: kaivo_2

    property alias k1_fork_921: k1_fork_921
    property alias k1_fork_lavaur: k1_fork_lavaur
    property alias k2_fork_921: k2_fork_921
    property alias k2_fork_lavaur: k2_fork_lavaur

    property alias k1_fork_amp: k1_fork_amp

    property bool kaivo_1_ready: false
    property bool kaivo_2_ready: false
    property bool absynth_ready: false

    // kaivo presets enumeration:
    property int autochurch:    0
    property int churchbells:   1
    property int yguitar:       2
    property int jguitar:       3
    property int tguitar:       4
    property int markhor:       5
    property int niwood:        6
    property int spring:        7
    property int vare:          8
    property int rainbells:     9
    property int varerhythm:    10

    WPN114.Rooms
    {
        id: instruments_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup
        exposePath: "/instruments/rooms"

        WPN114.StereoSource //----------------------------------------------------- KAIVO_1
        {
            id: kaivo_1_source
            xspread: 0.25
            diffuse: 0.55
            y: 0.75

            exposePath: "/instruments/kaivo-1/source"

            WPN114.AudioPlugin
            {
                id: kaivo_1
                path: "/Library/Audio/Plug-Ins/VST/Kaivo.vst"
                exposePath: "/instruments/kaivo-1"
                active: false

                function setPreset(enm) {
                    kaivo_1.programChange(0, enm);
                }

                WPN114.Fork { target: effects.reverb; id: k1_fork_921
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-1/forks/921" }

                WPN114.Fork { target: effects.lavaur; active: false; id: k1_fork_lavaur
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-1/forks/lavaur" }

                WPN114.Fork
                {
                    id: k1_fork_amp
                    target: effects.amplitube;
                    dBlevel: 0.0
                    prefader: true
                    active: false
                    exposePath: "/instruments/kaivo-1/forks/amplitube"
                }
            }
        }

        WPN114.StereoSource //----------------------------------------------------- KAIVO_2
        {
            id: kaivo_2_source

            xspread: 0.25
            diffuse: 0.55
            y: 0.75            

            exposePath: "/instruments/kaivo-2/source"

            WPN114.AudioPlugin
            {
                id: kaivo_2
                path: "/Library/Audio/Plug-Ins/VST/Kaivo.vst"
                exposePath: "/instruments/kaivo-2"
                active: false

                function setPreset(enm) {
                    kaivo_2.programChange(0, enm);
                }

                WPN114.Fork { target: effects.reverb; id: k2_fork_921
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-2/forks/921" }

                WPN114.Fork { target: effects.lavaur; active: false; id: k2_fork_lavaur
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-1/forks/lavaur" }
            }
        }
    }
}
