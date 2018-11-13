import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../../engine"
import ".."

Scene
{
    id: root;

    scenario: InteractionExecutor
    {
        target:       interaction_transition
        source:       audiostream
        parentNode:   parent.scenario;
        length:       min( 1.47 )
        countdown:    sec( 5 )

        onStart:
        {
            flute.play       ( );
            leaves.play      ( );
            woodworks.play   ( );
            insects.play     ( );
            digigreen.play   ( );
        }

        WPN114.Automation
        {
            target:     rooms
            property:   "level"
            duration:   sec( 10 )

            from: 0; to: rooms.level;
        }
    }

    Interaction //----------------------------------------------------- PANDO_TRANSITION
    {
        id:         interaction_transition
        title:      "Transition, Pando"
        module:     "quarre/Transitions.qml"
        broadcast:  true

        description: "transition, veuillez patienter..."
    }


    WPN114.StereoSource //----------------------------------------- 1.FLUTE (1-2)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.25
        diffuse: 0.2
        y: 0.9

        exposePath: fmt("audio/flute/source")

        WPN114.StreamSampler { id: flute;
            path: "audio/woodpath/pando/flute.wav"
            WPN114.Fork { target: effects.reverb; prefader: true; dBlevel: 6 }
        }
    }

    WPN114.StereoSource //----------------------------------------- 2.LEAVES (3-4)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.4
        exposePath: fmt("audio/leaves/source")

        WPN114.StreamSampler { id: leaves; dBlevel: 3
            path: "audio/woodpath/pando/leaves.wav"
            WPN114.Fork { target: effects.reverb; prefader: true; dBlevel: 0 }
        }
    }

    WPN114.StereoSource //----------------------------------------- 3.WOODWORKS (5-6)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.25
        diffuse: 0.2

        exposePath: fmt("audio/woodworks/source")

        WPN114.StreamSampler { id: woodworks; dBlevel: 3
            path: "audio/woodpath/pando/woodworks.wav"
            WPN114.Fork { target: effects.reverb; prefader: true; dBlevel: -6 }
        }
    }

    WPN114.StereoSource //----------------------------------------- 4.INSECTS (7-8)
    {
        parentStream: rooms
        fixed: true
        yspread: 0.25

        exposePath: fmt("audio/insects/source")

        WPN114.StreamSampler { id: insects; dBlevel: 6
            path: "audio/woodpath/pando/insects.wav"
            WPN114.Fork { target: effects.reverb; prefader: true; dBlevel: -3 }
        }
    }

    WPN114.StereoSource //----------------------------------------- 5.DIGIGREEN (9-10)
    {
        parentStream: rooms
        xspread: 0.35
        y: 0.2
        diffuse: 0.25

        fixed: true
        exposePath: fmt("audio/sources/digigreen")

        WPN114.StreamSampler { id: digigreen; dBlevel: 3
            path: "audio/woodpath/pando/digigreen.wav"
            WPN114.Fork { target: effects.reverb; prefader: true; dBlevel: -3 }
        }
    }

    //        WPN114.StereoSource //----------------------------------------- 6.VERB (11-12)
    //        {
    //            xspread: 0.15
    //            diffuse: 0.5
    //            y: 0.4

    //            fixed: true
    //            exposePath: fmt("audio/sources/verb"

    //            WPN114.StreamSampler { id: verb;
    //                path: "audio/woodpath/pando/verb.wav" }
    //        }
}
