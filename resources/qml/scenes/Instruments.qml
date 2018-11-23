import QtQuick 2.10
import WPN114 1.0 as WPN114

Item
{
    id: root

    property string path: "/scenario/instruments"

    property alias rooms:               instruments_rooms
    property alias kaivo_1:             kaivo_1
    property alias kaivo_2:             kaivo_2
    property alias k1_fork_921:         k1_fork_921
    property alias k1_fork_lavaur:      k1_fork_lavaur
    property alias k2_fork_921:         k2_fork_921
    property alias k2_fork_lavaur:      k2_fork_lavaur
    property alias k1_fork_amp:         k1_fork_amp

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

    function fmt(str)
    {
        return path+"/"+str
    }

    WPN114.Rooms
    {
        id: instruments_rooms
        active: false
        parentStream: audiostream
        setup: roomsetup
        exposePath: "/scenario/instruments/rooms"

        WPN114.StereoSource //====================================================  KAIVO_1
        {
            id: kaivo_1_source
            xspread: 0.25
            diffuse: 0.55
            y: 0.75
            z: 0.4

            exposePath: fmt("kaivo-1/source")

            WPN114.AudioPlugin //==============================================
            {
                id: kaivo_1
                path: "/Library/Audio/Plug-Ins/VST/Kaivo.vst"
                exposePath: fmt("kaivo-1")
                active: false

                function setPreset(enm) {
                    kaivo_1.programChange(0, enm);
                }

                WPN114.Fork // =============================================== FORK_921
                {
                    id: k1_fork_921
                    exposePath: fmt("kaivo-1/forks/921")
                    target: effects.reverb;
                    prefader: true                    
                }

                WPN114.Fork // =============================================== FORK_LAVAUR
                {
                    id: k1_fork_lavaur
                    exposePath: fmt("kaivo-1/forks/lavaur")
                    active: false
                    target: effects.lavaur
                    prefader: true                    
                }

                WPN114.Fork // =============================================== FORK_AMPLITUBE
                {
                    id: k1_fork_amp
                    exposePath: fmt("kaivo-1/forks/amplitube")
                    target: effects.amplitube;
                    prefader: true
                    active: false                    
                }
            }
        }

        WPN114.StereoSource //================================================== KAIVO_2
        {
            id: kaivo_2_source
            exposePath: fmt("kaivo-2/source")

            xspread: 0.25
            diffuse: 0.55
            y: 0.75
            z: 0.4

            WPN114.AudioPlugin //==============================================
            {
                id: kaivo_2
                exposePath: fmt("kaivo-2")
                path: "/Library/Audio/Plug-Ins/VST/Kaivo.vst"                
                active: false

                function setPreset(enm) {
                    kaivo_2.programChange(0, enm);
                }

                WPN114.Fork // =============================================== FORK_921
                {
                    id: k2_fork_921
                    exposePath: fmt("kaivo-2/forks/921")
                    target: effects.reverb
                    prefader: true                    
                }

                WPN114.Fork // =============================================== FORK_LAVAUR
                {
                    id: k2_fork_lavaur
                    exposePath: fmt("kaivo-2/forks/lavaur")
                    target: effects.lavaur
                    active: false
                    prefader: true                    
                }
            }
        }
    }
}
