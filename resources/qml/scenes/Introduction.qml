import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."

Item
{
    id: root

    property string path
    property alias rooms:           introduction_rooms
    property alias scenario:        introduction_scenario
    property int xroads_result:     0

    signal end()

    WPN114.TimeNode
    {
        id: introduction_scenario
        exposePath: "/introduction/scenario"

        source: audio_stream
        duration: min ( 4.42 )

        onEnd: introduction_rooms.active = false;

        onStart:
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

            // for synchronization purposes, active the container in last
            introduction_rooms.active   = true;

            client_manager.notifyStart( );
            client_manager.notifyScene("introduction");

            if ( !timer.running ) timer.start();
        }

        WPN114.TimeNode { date: min(3); onStart: root.end() }

        InteractionExecutor
        {
            id:         tutorial_event
            target:     tutorial_interaction
            date:       sec( 1 )
            countdown:  sec( 48 )
            length:     sec( 50 )
        }

        InteractionExecutor
        {
            id:         crossroads_event
            target:     crossroads_interaction

            date:       min( 1.45 )
            length:     sec( 30 )
            countdown:  sec( 30 )
        }
    }

    Item//------------------------------------------------------------------------------ INTERACTIONS
    {
        Interaction //----------------------------------------------------- TUTORIAL
        {
            id: tutorial_interaction
            path: "/introduction/interactions/tutorial"

            title: "Didacticiel"
            module: "quarre/Tutorial.qml"
            broadcast: true

            description:
                "Présentation du fonctionnement global de l'application"
        }

        Interaction //---------------------------------------------------- CROSSROADS
        {
            id: crossroads_interaction
            path: "/introduction/interactions/crossroads"

            title: "Croisée des chemins"
            module: "quarre/Vote.qml"
            broadcast: true

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
                        owner.remote.ignore("/modules/crossroads/selection");
                    }
                });

                if ( res_one > res_zero && res_one > res_two )
                    total = 0;

                else if ( res_two > res_zero && res_two > res_one )
                    total = 1;

                else total = Math.floor(Math.random()*2);

                root.xroads_result = total;
                console.log("crossroads result:", total);
            }
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
            xspread: 0.28
            fixed: true
            y: 0.65

            exposePath: "/introduction/audio/dragon-hi/source"

            WPN114.StreamSampler { id: dragon_hi; dBlevel: 3.00
                exposePath: "/introduction/audio/dragon-hi"
                path: "audio/introduction/dragon-hi.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.DRAGON_LOW (7-8)
        {
            xspread: 0.28
            fixed: true
            y: 0.25

            exposePath: "/introduction/audio/dragon-lo/source"

            WPN114.StreamSampler { id: dragon_lo; dBlevel: 6.00
                exposePath: "/introduction/audio/dragon-lo"
                path: "audio/introduction/dragon-lo.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.WALKING_1 (9-10)
        {
            xspread: 0.2
            fixed: true

            exposePath: "/introduction/audio/walking-1/source"

            WPN114.StreamSampler { id: walking_1;
                exposePath: "/introduction/audio/walking-1"
                path: "audio/introduction/walking-1.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 6.WALKING_2 (11-12)
        {
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
            xspread: 0.25
            fixed: true
            y: 0.85

            exposePath: "/introduction/audio/synth/source"

            WPN114.StreamSampler { id: synth; dBlevel: 6.00
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
