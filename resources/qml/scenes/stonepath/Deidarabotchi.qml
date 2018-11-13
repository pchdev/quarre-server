import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../../engine"
import ".."

Scene
{    
    id: root

    scenario: InteractionExecutor
    {
        target:      interaction_transition
        source:      audiostream
        parentNode:  parent.scenario
        duration:    WPN114.TimeNode.Infinite

        length:      min( 2.44 )
        countdown:   sec( 20 )

        onStart:
        {
            kaivo.play       ();
            synth.play       ();
            breath.play      ();
            wind.play        ();
            background.play  ();
        }
    }

    Interaction //----------------------------------------------------- TUTORIAL
    {
        id: interaction_transition
        title: "Transition, ダイダラボッチ "
        module: "quarre/Transitions.qml"
        broadcast: true

        description: "transition, veuillez patienter..."
    }

    WPN114.StereoSource //----------------------------------------- 1.KAIVO (1-2)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.2
        diffuse: 0.55
        y: 0.55

        exposePath: fmt("audio/kaivo/source")

        WPN114.StreamSampler { id: kaivo; attack: 2000
            exposePath: fmt("audio/kaivo")
            path: "audio/stonepath/deidarabotchi/kaivo.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 2.SYNTH (3-4)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.15
        diffuse: 0.3
        y: 0.9

        exposePath: fmt("audio/synth/source")

        WPN114.StreamSampler { id: synth; attack: 2000
            exposePath: fmt("audio/synth")
            path: "audio/stonepath/deidarabotchi/synth.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 3.BACKGROUND (5-6)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.35
        diffuse: 0.9

        exposePath: fmt("audio/background/source")

        WPN114.StreamSampler { id: background; attack: 2000
            exposePath: fmt("audio/background")
            path: "audio/stonepath/deidarabotchi/background.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 4.BREATH (7-8)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.1
        diffuse: 0.25
        y: 0.55

        exposePath: fmt("audio/breath/source")

        WPN114.StreamSampler { id: breath; attack: 2000
            exposePath: fmt("audio/breath")
            path: "audio/stonepath/deidarabotchi/breath.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 5.WIND (9-10)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.25
        diffuse: 0.5
        y: 0.25

        exposePath: fmt("audio/wind/source")

        WPN114.StreamSampler { id: wind; attack: 2000
            exposePath: fmt("audio/wind")
            path: "audio/stonepath/deidarabotchi/wind.wav" }
    }
}
