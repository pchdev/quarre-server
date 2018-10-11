import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."

Item
{
    property alias rooms: introduction_rooms
    property alias crossroads: crossroads
    property alias tutorial: tutorial

    Item//------------------------------------------------------------------------------ INTERACTIONS
    {
        Interaction //----------------------------------------------------- TUTORIAL
        {
            id: tutorial
            path: "introduction/tutorial"

            title: "Didacticiel"
            module: "quarre/Tutorial.qml"
            broadcast: true
            length: 50;
            countdown: 48

            description:
                "Présentation du fonctionnement global de l'application"

            onInteractionNotify:
            {
                owners.forEach(function(owner) {
                    if ( owner.connected ) owner.remote.listen("/scenario/name");
                });
            }
        }

        Interaction //---------------------------------------------------- CROSSROADS
        {
            id: crossroads
            path: "introduction/crossroads"

            title: "Croisée des chemins"
            module: "quarre/Vote.qml"
            broadcast: true
            length: 30
            countdown: 30

            description: "sélectionnez l'un des symboles présentés ci-dessous. " +
                         "Ce choix influencera le déroulement du scénario."

            onInteractionBegin:
            {
                owners.forEach(function(owner) {
                    if ( owner.connected ) owner.remote.listen("/modules/crossroads/selection");
                });
            }

            onInteractionEnd:
            {
                // parse selection for each connected client
                var res_zero = 0, res_one = 0, res_two = 0, total = 0;

                owners.forEach(function(owner){
                    if ( owner.connected )
                    {
                        var res = owner.remote.value("/modules/crossroads/selection");
                        if ( res === 0 ) res_zero++;
                        else if ( res === 1 ) res_one++;
                        else if ( res === 2 ) res_two++;
                    }
                });

                if ( res_one > res_zero && res_one > res_two )
                    total = 0;

                else if ( res_two > res_zero && res_two > res_one )
                    total = 1;

                else total = Math.floor(Math.random()*2);
                crossroads_result.value = total;
            }
        }
    }

    WPN114.Node //--------------------------------------------------------------- CROSSROADS_RESULT
    {
        id: crossroads_result
        type: WPN114.Type.Int
        path: "/interactions/introduction/crossroads/result"
        value: 0
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

            if ( newValue )
            {
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
            else
            {
                digibirds.stop      ( );
                swarms.stop         ( );
                dragon_hi.stop      ( );
                dragon_lo.stop      ( );
                walking_1.stop      ( );
                walking_2.stop      ( );
                synth.stop          ( );
                spring.stop         ( );
                river.stop          ( );
                verb.stop           ( );
            }

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

        exposePath: "/audio/introduction/rooms"

        WPN114.RoomSource //----------------------------------------- 1.DIGIBIRDS (1-2)
        {
            exposePath: "/audio/introduction/digibirds/rooms"

            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            fixed:      true

            WPN114.StreamSampler { id: digibirds;
                exposePath: "/audio/introduction/digibirds"
                path: "audio/introduction/digibirds.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.SWARMS (3-4)
        {
            exposePath: "/audio/introduction/swarms/rooms"

            position:   [ [ 0.232, 0.884, 0.5], [ 0.774, 0.881, 0.5 ] ]
            diffuse:    [ 0.17, 0.17 ]
            fixed:      true

            WPN114.StreamSampler { id: swarms;
                exposePath: "/audio/introduction/swarms"
                path: "audio/introduction/swarms.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.DRAGON_HIGH (5-6)
        {
            exposePath: "/audio/introduction/dragon-hi/rooms"
            position:   [ [ 0.22, 0.65, 0.5 ], [ 0.783, 0.637, 0.5 ]]
            fixed:      true

            WPN114.StreamSampler { id: dragon_hi;
                exposePath: "/audio/introduction/dragon-hi"
                path: "audio/introduction/dragon-hi.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.DRAGON_LOW (7-8)
        {
            exposePath: "/audio/introduction/dragon-lo/rooms"
            position:   [ [0.227, 0.25, 0.5], [0.774, 0.257, 0.5] ]
            fixed:      true

            WPN114.StreamSampler { id: dragon_lo;
                exposePath: "/audio/introduction/dragon-lo"
                path: "audio/introduction/dragon-lo.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.WALKING_1 (9-10)
        {
            exposePath: "/audio/introduction/walking-1/rooms"
            position:   [ [0.407, 0.5, 0.5], [0.587, 0.5, 0.5] ]
            fixed:      true

            WPN114.StreamSampler { id: walking_1;
                exposePath: "/audio/introduction/walking-1"
                path: "audio/introduction/walking-1.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.WALKING_2 (11-12)
        {
            exposePath: "/audio/introduction/walking-2/rooms"
            position:   [ [0.43, 0.431, 0.5], [ 0.554, 0.431, 0.5]]
            fixed:      true

            WPN114.StreamSampler { id: walking_2;
                exposePath: "/audio/introduction/walking-2"
                path: "audio/introduction/walking-2.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 7.SYNTH (13-14)
        {
            exposePath: "/audio/introduction/synth/rooms"
            position:   [ [0.245, 0.837, 0.5], [0.749, 0.84, 0.5]]
            fixed:      true

            WPN114.StreamSampler { id: synth;
                exposePath: "/audio/introduction/synth"
                path: "audio/introduction/synth.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 8.SPRING (15-16)
        {
            exposePath: "/audio/introduction/spring/rooms"
            position:   [ [0.5, 0.776, 0.5], [0.5, 0.169, 0.5] ]
            diffuse:    [ 0.7, 0.7 ]
            bias:       [ 0.85, 0.85 ]

            fixed:      true

            WPN114.StreamSampler { id: spring;
                exposePath: "/audio/introduction/spring"
                path: "audio/introduction/spring.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 9.RIVER (17-18)
        {
            exposePath: "/audio/introduction/river/rooms"
            position:   [ [0.493, 0.788, 0.5], [0.497, 0.251, 0.5] ]
            diffuse:    [ 0.54, 0.54 ]

            fixed:      true

            WPN114.StreamSampler { id: river;
                exposePath: "/audio/introduction/river"
                path: "audio/introduction/river.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 10.VERB (19-20)
        {
            exposePath: "/audio/introduction/verb/rooms"
            position:   [ [0.259, 0.502, 0.5], [0.713, 0.5, 0.5]]
            diffuse:    [ 0.6, 0.6 ]

            fixed:      true

            WPN114.StreamSampler { id: verb;
                exposePath: "/audio/introduction/verb"
                path: "audio/introduction/verb.wav" }
        }
    }
}
