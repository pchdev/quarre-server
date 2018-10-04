import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."

Item
{
    Item//------------------------------------------------------------------------------ INTERACTIONS
    {
        Interaction //----------------------------------------------------- TUTORIAL
        {
            id: tutorial
            title: "Didacticiel"
            module: "quarre/Tutorial.qml"
            broadcast: true
            length: 50;
            countdown: 48

            description:
                "Présentation du fonctionnement global de l'application"
        }

        Interaction //---------------------------------------------------- CROSSROADS
        {
            id: crossroads
            title: "Croisée des chemins"
            module: "quarre/Vote.qml"
            broadcast: true
            length: 30
            countdown: 30

            description:
                "sélectionnez l'un des symboles présentés ci-dessous
                 ce choix influencera le déroulement du scénario."
        }
    }

    WPN114.Node //------------------------------------------------------------------------- CONTROL
    {
        type: WPN114.Type.Bool
        path: "/audio/introduction/play"
        onValueReceived:
        {
            introduction_rooms.active   = newValue;
            digibirds.active            = newValue;
            swarms.active               = newValue;
            dragon_hi.active            = newValue;
            dragon_lo.active            = newValue;
            walking_1.active            = newValue;
            walking_2.active            = newValue;
            synth.active                = newValue;
            spring.active               = newValue;
            river.active                = newValue;
            verb.active                 = newValue;

            digibirds.play      ( );
            swarms.play         ( );
            dragon_hi.play      ( );
            dragon_lo.play      ( );
            walking_1.play      ( );
            walking_2.play      ( );
            synth.play          ( );
            spring.play         ( );
            river.play          ( );
            verb.play           ( );
        }
    }

    WPN114.Rooms //---------------------------------------------------------------------- AUDIO
    {
        id: introduction_rooms
        parentStream: audio_stream
        setup: rooms_setup
        active: false

        exposePath: "/audio/introduction/rooms"

        WPN114.RoomSource //----------------------------------------- 1.DIGIBIRDS (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/digibirds"

            WPN114.StreamSampler { id: digibirds;
                path: "audio/introduction/digibirds.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.SWARMS (3-4)
        {
            position:   [ [ 0.232, 0.884, 0.5], [ 0.774, 0.881, 0.5 ] ]
            diffuse:    [ 0.17, 0.17 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/swarms"

            WPN114.StreamSampler { id: swarms;
                path: "audio/introduction/swarms.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.DRAGON_HIGH (5-6)
        {
            position:   [ [ 0.22, 0.65, 0.5 ], [ 0.783, 0.637, 0.5 ]]
            diffuse:    [ 0.0, 0.0 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/dragon-hi"

            WPN114.StreamSampler { id: dragon_hi;
                path: "audio/introduction/dragon-hi.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.DRAGON_LOW (7-8)
        {
            position:   [ [0.227, 0.25, 0.5], [0.774, 0.257, 0.5] ]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/dragon-lo"

            WPN114.StreamSampler { id: dragon_lo;
                path: "audio/introduction/dragon-lo.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.WALKING_1 (9-10)
        {
            position:   [ [0.407, 0.5, 0.5], [0.587, 0.5, 0.5] ]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/walking-1"

            WPN114.StreamSampler { id: walking_1;
                path: "audio/introduction/walking-1.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.WALKING_2 (11-12)
        {
            position:   [ [0.43, 0.431, 0.5], [ 0.554, 0.431, 0.5]]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/walking-2"

            WPN114.StreamSampler { id: walking_2;
                path: "audio/introduction/walking-2.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 7.SYNTH (13-14)
        {
            position:   [ [0.245, 0.837, 0.5], [0.749, 0.84, 0.5]]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/synth"

            WPN114.StreamSampler { id: synth;
                path: "audio/introduction/synth.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 8.SPRING (15-16)
        {
            position:   [ [0.5, 0.776, 0.5], [0.5, 0.169, 0.5] ]
            diffuse:    [ 0.7, 0.7 ]
            bias:       [ 0.85, 0.85 ]

            WPN114.StreamSampler { id: spring;
                path: "audio/introduction/spring.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 9.RIVER (17-18)
        {
            position:   [ [0.493, 0.788, 0.5], [0.497, 0.251, 0.5] ]
            diffuse:    [ 0.54, 0.54 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/river"

            WPN114.StreamSampler { id: river;
                path: "audio/introduction/river.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 10.VERB (19-20)
        {
            position:   [ [0.259, 0.502, 0.5], [0.713, 0.5, 0.5]]
            diffuse:    [ 0.6, 0.6 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/introduction/rooms/sources/verb"

            WPN114.StreamSampler { id: verb;
                path: "audio/introduction/verb.wav" }
        }


    }
}
