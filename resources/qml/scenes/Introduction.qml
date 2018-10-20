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
            path: "/introduction/interactions/tutorial"

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
            path: "/introduction/interaction/crossroads"

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
                    if ( owner.connected )
                         owner.remote.listen("/modules/crossroads/selection");
                });
            }

            onInteractionEnd:
            {
                // parse selection for each connected client
                var res_zero = 0, res_one = 0, res_two = 0, total = 0;

                owners.forEach(function(owner) {
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
        path: "/introduction/interactions/crossroads/result"
    }

    WPN114.Node //------------------------------------------------------------------------- CONTROL
    {
        type: WPN114.Type.Bool
        path: "/introduction/audio/play"
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

        exposePath: "/introduction/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.DIGIBIRDS (1-2)
        {
            dBlevel: 0
            xspread: 0.35
            diffuse: 0.49
            fixed: true

            exposePath: "/introduction/audio/digibirds/source"

            WPN114.StreamSampler { id: digibirds;
                exposePath: "/introduction/audio/digibirds"
                path: "audio/introduction/digibirds.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.SWARMS (3-4)
        {
            dBlevel: 0
            xspread: 0.27
            diffuse: 0.17
            fixed: true
            y: 0.9

            exposePath: "/introduction/audio/swarms/source"

            WPN114.StreamSampler { id: swarms;
                exposePath: "/introduction/audio/swarms"
                path: "audio/introduction/swarms.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.DRAGON_HIGH (5-6)
        {
            dBlevel: 3.00
            xspread: 0.28
            fixed: true
            y: 0.65

            exposePath: "/introduction/audio/dragon-hi/source"

            WPN114.StreamSampler { id: dragon_hi;
                exposePath: "/introduction/audio/dragon-hi"
                path: "audio/introduction/dragon-hi.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.DRAGON_LOW (7-8)
        {
            dBlevel: 6.00
            xspread: 0.28
            fixed: true
            y: 0.25

            exposePath: "/introduction/audio/dragon-lo/source"

            WPN114.StreamSampler { id: dragon_lo;
                exposePath: "/introduction/audio/dragon-lo"
                path: "audio/introduction/dragon-lo.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.WALKING_1 (9-10)
        {
            dBlevel: 0.0
            xspread: 0.2
            fixed: true

            exposePath: "/introduction/audio/walking-1/source"

            WPN114.StreamSampler { id: walking_1;
                exposePath: "/introduction/audio/walking-1"
                path: "audio/introduction/walking-1.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 6.WALKING_2 (11-12)
        {
            dBlevel: 0.00
            xspread: 0.15
            fixed: true
            y: 0.43

            exposePath: "/introduction/audio/walking-2/source"

            WPN114.StreamSampler { id: walking_2;
                exposePath: "/introduction/audio/walking-2"
                path: "audio/introduction/walking-2.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 7.SYNTH (13-14)
        {
            dBlevel: 6.00
            xspread: 0.25
            fixed: true
            y: 0.85

            exposePath: "/introduction/audio/synth/source"

            WPN114.StreamSampler { id: synth;
                exposePath: "/introduction/audio/synth"
                path: "audio/introduction/synth.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 8.SPRING (15-16)
        {            
            yspread: 0.25
            diffuse: 0.7
            bias: 0.85
            fixed: true

            exposePath: "/introduction/audio/spring/source"

            WPN114.StreamSampler { id: spring;
                exposePath: "/introduction/audio/spring"
                path: "audio/introduction/spring.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 9.RIVER (17-18)
        {
            yspread: 0.25
            diffuse: 0.55
            fixed: true

            exposePath: "/introduction/audio/river/source"

            WPN114.StreamSampler { id: river;
                exposePath: "/introduction/audio/river"
                path: "audio/introduction/river.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 10.VERB (19-20)
        {
            xspread: 0.25
            diffuse: 0.6
            fixed: true

            exposePath: "/introduction/audio/verb/source"

            WPN114.StreamSampler { id: verb;
                exposePath: "/introduction/audio/verb"
                path: "audio/introduction/verb.wav" }
        }
    }
}
