import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    property alias rooms:       pando_rooms
    property alias scenario:    scenario
    signal end()

    InteractionExecutor
    {
        id:         scenario
        target:     interaction_transition
        source:     audio_stream

        exposePath: "/woodpath/pando/scenario"

        length:     sec( 104 )
        countdown:  sec( 5 )

        onStart:
        {           
            flute.play      ( );
            leaves.play     ( );
            woodworks.play  ( );
            insects.play    ( );
            digigreen.play  ( );
            verb.play       ( );

            pando_rooms.active = true;
            client_manager.notifyScene("pando");
        }

        WPN114.Automation
        {
            target:     pando_rooms
            property:   "level"
            duration:   sec( 20 )

            from: 0; to: 1;
        }

        onEnd:
        {
            pando_rooms.active = false;
            root.end();
        }

    }

    Interaction //----------------------------------------------------- PANDO_TRANSITION
    {
        id: interaction_transition
        path: "/woodpath/pando/interactions/transition"

        title: "Transition, Pando"
        module: "quarre/Transitions.qml"
        broadcast: true
        description: "transition, veuillez patienter..."
    }

    WPN114.Rooms
    {
        id: pando_rooms
        parentStream: audio_stream
        setup: rooms_setup
        active: false

        exposePath: "/woodpath/pando/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.FLUTE (1-2)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.4
            y: 0.9

            exposePath: "/woodpath/pando/audio/flute/source"

            WPN114.StreamSampler { id: flute;
                path: "audio/woodpath/pando/flute.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.LEAVES (3-4)
        {
            fixed: true
            xspread: 0.4
            exposePath: "/woodpath/pando/audio/leaves/source"

            WPN114.StreamSampler { id: leaves;
                path: "audio/woodpath/pando/leaves.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.WOODWORKS (5-6)
        {          
            fixed: true
            xspread: 0.15
            diffuse: 0.4

            exposePath: "/woodpath/pando/audio/woodworks/source"

            WPN114.StreamSampler { id: woodworks;
                path: "audio/woodpath/pando/woodworks.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.INSECTS (7-8)
        {
            fixed: true
            yspread: 0.25

            exposePath: "/woodpath/pando/audio/insects/source"

            WPN114.StreamSampler { id: insects;
                path: "audio/woodpath/pando/insects.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.DIGIGREEN (9-10)
        {
            xspread: 0.35
            y: 0.2
            diffuse: 0.25

            fixed: true
            exposePath: "/woodpath/pando/audio/sources/digigreen"

            WPN114.StreamSampler { id: digigreen;
                path: "audio/woodpath/pando/digigreen.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 6.VERB (11-12)
        {
            xspread: 0.15
            diffuse: 0.5
            y: 0.4

            fixed: true
            exposePath: "/woodpath/pando/audio/sources/verb"

            WPN114.StreamSampler { id: verb;
                path: "audio/woodpath/pando/verb.wav" }
        }
    }

}
