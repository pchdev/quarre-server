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
            digibirds.active     = newValue;
            swarms.active        = newValue;
            dragon_hi.active     = newValue;
            dragon_lo.active     = newValue;
            walking_1.active     = newValue;
            walking_2.active     = newValue;
            synth.active         = newValue;
            spring.active        = newValue;
            river.active         = newValue;
            verb.active          = newValue;

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

            // for synchronization purposes, active the container in last
            introduction_rooms.active   = newValue;
        }
    }

    WPN114.Rooms //---------------------------------------------------------------------- AUDIO
    {
        id: introduction_rooms
        parentStream: audio_stream
        setup: rooms_setup
        active: false

        WPN114.Node on active { path: "/audio/introduction/rooms/active" }
        WPN114.Node on dBlevel { path: "/audio/introduction/rooms/level" }

        WPN114.RoomSource //----------------------------------------- 1.DIGIBIRDS (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/digibirds/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/digibirds/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/digibirds/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/digibirds/rotate" }

            WPN114.StreamSampler { id: digibirds;
                WPN114.Node on dBlevel { path: "/audio/introduction/digibirds/level" }
                path: "audio/introduction/digibirds.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.SWARMS (3-4)
        {
            position:   [ [ 0.232, 0.884, 0.5], [ 0.774, 0.881, 0.5 ] ]
            diffuse:    [ 0.17, 0.17 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/swarms/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/swarms/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/swarms/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/swarms/rotate" }

            WPN114.StreamSampler { id: swarms;
                WPN114.Node on dBlevel { path: "/audio/introduction/swarms/level" }
                path: "audio/introduction/swarms.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.DRAGON_HIGH (5-6)
        {
            position:   [ [ 0.22, 0.65, 0.5 ], [ 0.783, 0.637, 0.5 ]]
            diffuse:    [ 0.0, 0.0 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/dragon-hi/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/dragon-hi/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/dragon-hi/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/dragon-hi/rotate" }

            WPN114.StreamSampler { id: dragon_hi;
                WPN114.Node on dBlevel { path: "/audio/introduction/dragon-hi/level" }
                path: "audio/introduction/dragon-hi.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.DRAGON_LOW (7-8)
        {
            position:   [ [0.227, 0.25, 0.5], [0.774, 0.257, 0.5] ]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            fixed:      true

            WPN114.Node on position { path: "/audio/introduction/dragon-lo/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/dragon-lo/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/dragon-lo/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/dragon-lo/rotate" }

            WPN114.StreamSampler { id: dragon_lo;
                WPN114.Node on dBlevel { path: "/audio/introduction/dragon-lo/level" }
                path: "audio/introduction/dragon-lo.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.WALKING_1 (9-10)
        {
            position:   [ [0.407, 0.5, 0.5], [0.587, 0.5, 0.5] ]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/walking-1/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/walking-1/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/walking-1/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/walking-1/rotate" }

            WPN114.StreamSampler { id: walking_1;
                WPN114.Node on dBlevel { path: "/audio/introduction/walking-1/level" }
                path: "audio/introduction/walking-1.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.WALKING_2 (11-12)
        {
            position:   [ [0.43, 0.431, 0.5], [ 0.554, 0.431, 0.5]]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/walking-2/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/walking-2/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/walking-2/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/walking-2/rotate" }

            WPN114.StreamSampler { id: walking_2;
                WPN114.Node on dBlevel { path: "/audio/introduction/walking-2/level" }
                path: "audio/introduction/walking-2.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 7.SYNTH (13-14)
        {
            position:   [ [0.245, 0.837, 0.5], [0.749, 0.84, 0.5]]
            diffuse:    [ 0.00, 0.00 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/synth/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/synth/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/synth/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/synth/rotate" }

            WPN114.StreamSampler { id: synth;
                WPN114.Node on dBlevel { path: "/audio/introduction/synth/level" }
                path: "audio/introduction/synth.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 8.SPRING (15-16)
        {
            position:   [ [0.5, 0.776, 0.5], [0.5, 0.169, 0.5] ]
            diffuse:    [ 0.7, 0.7 ]
            bias:       [ 0.85, 0.85 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/spring/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/spring/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/spring/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/spring/rotate" }

            WPN114.StreamSampler { id: spring;
                WPN114.Node on dBlevel { path: "/audio/introduction/spring/level" }
                path: "audio/introduction/spring.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 9.RIVER (17-18)
        {
            position:   [ [0.493, 0.788, 0.5], [0.497, 0.251, 0.5] ]
            diffuse:    [ 0.54, 0.54 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/river/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/river/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/river/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/river/rotate" }

            WPN114.StreamSampler { id: river;
                WPN114.Node on dBlevel { path: "/audio/introduction/river/level" }
                path: "audio/introduction/river.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 10.VERB (19-20)
        {
            position:   [ [0.259, 0.502, 0.5], [0.713, 0.5, 0.5]]
            diffuse:    [ 0.6, 0.6 ]
            bias:       [ 0.5, 0.5 ]
            rotate:     [ 0.5, 0.5 ]

            WPN114.Node on position { path: "/audio/introduction/verb/position" }
            WPN114.Node on diffuse { path: "/audio/introduction/verb/diffuse" }
            WPN114.Node on bias { path: "/audio/introduction/verb/bias" }
            WPN114.Node on rotate { path: "/audio/introduction/verb/rotate" }

            WPN114.StreamSampler { id: verb;
                WPN114.Node on dBlevel { path: "/audio/introduction/verb/level" }
                path: "audio/introduction/verb.wav" }
        }
    }
}
