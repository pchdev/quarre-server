import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    id: root
    property alias rooms: instruments_rooms
    property alias kaivo_1: kaivo_1
    property alias kaivo_2: kaivo_2
    property alias absynth: absynth

    property alias k1_fork_921: k1_fork_921
    property alias k1_fork_lavaur: k1_fork_lavaur
    property alias k2_fork_921: k2_fork_921
    property alias k2_fork_lavaur: k2_fork_lavaur

    property bool kaivo_1_ready: false
    property bool kaivo_2_ready: false
    property bool absynth_ready: false

    property var kaivo_presets: new Object;

    // KAIVO - PRESETS
    Component.onCompleted:
    {
        root.kaivo_presets.spring         = 34;
        root.kaivo_presets.markhor        = 21;
        root.kaivo_presets.rainbells      = 25;
        root.kaivo_presets.church         = 38;
        root.kaivo_presets.autochurch     = 35;
        root.kaivo_presets.jguitar        = 37;
        root.kaivo_presets.temples        = 20;
        root.kaivo_presets.insects        = 6;
    }

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

                function setPreset(str) {
                    var res;
                    if ( str === "spring" ) res = 34;
                    else if ( str === "markhor") res = 21;
                    else if ( str === "rainbells") res = 25;
                    else if ( str === "church") res = 38;
                    else if ( str === "autochurch") res = 35;
                    else if ( str === "jguitar") res = 37;
                    else if ( str === "temples") res = 20;
                    else if ( str === "insects") res = 6;

                    kaivo_1.programChange(0, res);
                }

                WPN114.Fork { target: effects.reverb; id: k1_fork_921
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-1/forks/921" }

                WPN114.Fork { target: effects.lavaur; active: false; id: k1_fork_lavaur
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-1/forks/lavaur" }

                WPN114.Fork { target: effects.amplitube;
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

                function setPreset(str) {
                    var res;
                    if ( str === "spring" ) res = 34;
                    else if ( str === "markhor") res = 21;
                    else if ( str === "rainbells") res = 25;
                    else if ( str === "church") res = 38;
                    else if ( str === "autochurch") res = 35;
                    else if ( str === "jguitar") res = 37;
                    else if ( str === "temples") res = 20;
                    else if ( str === "insects") res = 6;

                    kaivo_2.programChange(0, res);
                }

                WPN114.Fork { target: effects.reverb; id: k2_fork_921
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-2/forks/921" }

                WPN114.Fork { target: effects.lavaur; active: false; id: k2_fork_lavaur
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/kaivo-1/forks/lavaur" }

                WPN114.Fork { target: effects.amplitube
                    dBlevel: 0.0
                    active: false
                    prefader: true
                    exposePath: "/instruments/kaivo-2/forks/amplitube"
                }
            }
        }

        WPN114.StereoSource //----------------------------------------------------- ABSYNTH
        {
            id: absynth_source

            xspread: 0.25
            diffuse: 0.55
            y: 0.75

            exposePath: "/instruments/absynth/source"

            WPN114.AudioPlugin
            {
                id: absynth
                path: "/Library/Audio/Plug-Ins/VST/Absynth 5 Stereo.vst"
                exposePath: "/instruments/absynth"
                active: false

                WPN114.Fork { target: effects.reverb;
                    dBlevel: 0.0
                    prefader: true
                    exposePath: "/instruments/absynth/forks/altiverb" }

                WPN114.Fork { target: effects.amplitube;
                    dBlevel: 0.0
                    active: false
                    prefader: true
                    exposePath: "/instruments/absynth/forks/amplitube"
                }
            }
        }
    }
}
