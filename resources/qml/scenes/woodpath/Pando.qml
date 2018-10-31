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
            verb.play       ( )

            instruments.rooms.active = false;

            pando_rooms.active = true;
            client_manager.notifyScene("pando");
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

        WPN114.RoomSource //----------------------------------------- 1.FLUTE (1-2)
        {
            exposePath: "/woodpath/pando/audio/flute/source"

            WPN114.Sampler { id: flute; stream: true;
                path: "audio/woodpath/pando/flute.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.LEAVES (3-4)
        {
            exposePath: "/woodpath/pando/audio/rooms/leaves/source"

            WPN114.Sampler { id: leaves; stream: true;
                path: "audio/woodpath/pando/leaves.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.WOODWORKS (5-6)
        {          

            exposePath: "/woodpath/pando/audio/rooms/woodworks/source"

            WPN114.Sampler { id: woodworks; stream: true;
                path: "audio/woodpath/pando/woodworks.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.INSECTS (7-8)
        {

            exposePath: "/woodpath/pando/audio/rooms/insects/source"

            WPN114.Sampler { id: insects; stream: true;
                path: "audio/woodpath/pando/insects.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.DIGIGREEN (9-10)
        {

            exposePath: "/woodpath/pando/audio/rooms/sources/digigreen"

            WPN114.Sampler { id: digigreen; stream: true;
                path: "audio/woodpath/pando/digigreen.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.VERB (11-12)
        {

            exposePath: "/woodpath/pando/audio/rooms/sources/verb"

            WPN114.Sampler { id: verb; stream: true;
                path: "audio/woodpath/pando/verb.wav" }
        }
    }

}
