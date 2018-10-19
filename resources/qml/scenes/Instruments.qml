import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property alias rooms: instruments_rooms
    property alias kaivo_1: kaivo_1
    property alias kaivo_2: kaivo_2
    property alias absynth: absynth

    // KAIVO - PRESETS

    // 34 - SPRING_GENERIC

    property var kaivo_presets: new Object

    Component.onCompleted:
    {
        kaivo_presets["spring"]         = 34;
        kaivo_presets["markhor"]        = 21;
        kaivo_presets["rainbells"]      = 35;
        kaivo_presets["churchbells"]    = 38;
        kaivo_presets["jguitar"]        = 37;
        kaivo_presets["temples"]        = 20;
        kaivo_presets["insects"]        = 6;
    }

    WPN114.Rooms
    {
        id: instruments_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup
        exposePath: "/audio/instruments/rooms"

        WPN114.StereoSource //----------------------------------------------------- KAIVO_1
        {
            xspread: 0.25
            diffuse: 0.55
            y: 0.75

            exposePath: "/audio/instruments/kaivo-1/source"

            WPN114.AudioPlugin
            {
                id: kaivo_1
                active: false
                path: "/Library/Audio/Plug-Ins/VST/Kaivo.vst"
                exposePath: "/audio/instruments/kaivo-1"

                function setPreset(str) {
                    kaivo_1.programChange(0, kaivo_presets[str]);
                }

                WPN114.Fork { target: effects.reverb; dBlevel: -6.0
                    exposePath: "/audio/instruments/kaivo-1/forks/altiverb" }

                WPN114.Fork { target: effects.amplitube; dBlevel: -6.0; active: false
                    exposePath: "/audio/instruments/kaivo-1/forks/amplitube"
                }
            }
        }

        WPN114.StereoSource //----------------------------------------------------- KAIVO_2
        {
            xspread: 0.25
            diffuse: 0.55
            y: 0.75

            exposePath: "/audio/instruments/kaivo-2/source"

            WPN114.AudioPlugin
            {
                id: kaivo_2
                active: false
                path: "/Library/Audio/Plug-Ins/VST/Kaivo.vst"
                exposePath: "/audio/instruments/kaivo-2"

                function setPreset(str) {
                    kaivo_2.programChange(0, kaivo_presets[str]);
                }

                WPN114.Fork { target: effects.reverb; dBlevel: -6.0
                    exposePath: "/audio/instruments/kaivo-2/forks/altiverb" }

                WPN114.Fork { target: effects.amplitube; dBlevel: -6.0; active: false
                    exposePath: "/audio/instruments/kaivo-2/forks/amplitube"
                }
            }
        }

        WPN114.StereoSource //----------------------------------------------------- ABSYNTH
        {
            xspread: 0.25
            diffuse: 0.55
            y: 0.75

            exposePath: "/audio/instruments/absynth/source"

            WPN114.AudioPlugin
            {
                id: absynth
                active: false
                path: "/Library/Audio/Plug-Ins/VST/Absynth 5.vst"
                exposePath: "/audio/instruments/absynth"

                WPN114.Fork { target: effects.reverb; dBlevel: -6.0
                    exposePath: "/audio/instruments/absynth/sends/altiverb" }

                WPN114.Fork { target: effects.amplitube; dBlevel: -6.0; active: false
                    exposePath: "/audio/instruments/absynth/sends/amplitube"
                }
            }
        }
    }
}
