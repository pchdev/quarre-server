import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    id: root

    property alias rooms: cendres_rooms
    property alias scenario: scenario

    signal next()
    property var target_thunder_executor: thunder_executor
    property var target_boiling_executor: boiling_executor

    WPN114.TimeNode
    {
        id: scenario
        source: audio_stream
        exposePath: "/stonepath/cendres/scenario"

        duration: -1

        onStart:
        {
            instruments.rooms.active = false;
            client_manager.notifyScene("cendres");
            cendres_rooms.active = true
            cendres_rooms.level = 1;

            if ( !timer.running ) timer.start();
        }

        InteractionExecutor //----------------------------------------------------- THUNDER
        {
            id:         thunder_executor
            target:     interaction_thunder

            date:       sec( 5 );
            countdown:  sec( 10 )
            length:     sec( 20 )

            onEnd:      target_thunder_executor = thunder_executor_loop

            WPN114.TimeNode
            {
                after:    parentNode
                date:     sec ( 30 )
                onStart:  thunder.playRandom()
            }

            WPN114.Loop //--------------------------------- THUNDER_LOOP
            {
                after:      parentNode
                date:       min ( 1.05 )
                duration:   min ( 2.30 )

                pattern.duration: sec( 35 )

                InteractionExecutor
                {
                    id:         thunder_executor_loop
                    target:     interaction_thunder
                    countdown:  sec( 10 )
                    length:     sec( 20 )
                }
            }
        }

        InteractionExecutor //----------------------------------------------------- BOILING
        {
            id:         boiling_executor
            target:     interaction_boiling

            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     sec( 20 )

            onEnd:      target_boiling_executor = boiling_loop_executor

            WPN114.TimeNode { after: parentNode; date: sec(2); onStart: burn.play() }
            WPN114.TimeNode { after: parentNode; date: sec(5); onStart: ashes.play() }

            WPN114.Loop //--------------------------------- BOILING_LOOP
            {
                after:      parentNode
                date:       sec ( 20 )
                duration:   min ( 2.30 )

                pattern.duration: sec(35)

                InteractionExecutor
                {
                    id:         boiling_loop_executor
                    target:     interaction_boiling
                    duration:   sec( 30 )
                    countdown:  sec( 10 )
                    length:     sec( 20 )
                }
            }
        }

        InteractionExecutor //------------------------------------------------ MARMOTS_BIRDS
        {
            id:         marmottes_execution
            target:     interaction_marmottes

            date:       sec( 35 )
            countdown:  sec( 15 )
            length:     sec( 45 )

            onStart:    groundwalk.stop();
        }

        InteractionExecutor
        {
            after:      marmottes_execution
            target:     interaction_flying_birds

            date:       sec( 25 );
            countdown:  sec( 15 );
            length:     sec( 60 );

            onEnd:      quarre.play();

            WPN114.TimeNode
            {
                after: parentNode; date: sec(15)
                onStart: necks.play();
            }

            WPN114.TimeNode
            {
                id: next_node
                after: parentNode; date: sec(25)
                onStart: root.next();
            }
        }

        InteractionExecutor //--------------------------------------------------- DRAGON_GROUNDWALK
        {
            id:         dragon_execution            
            target:     interaction_dragon

            date:       sec( 55 );
            countdown:  sec( 20 );
            length:     sec( 80 );

            onStart:    dragon.play()
            onEnd:      dragon.stop()
        }

        InteractionExecutor
        {
            after:      dragon_execution            
            target:     interaction_groundwalk

            date:       sec( 20 );
            countdown:  sec( 20 );
            length:     sec( 60 );

            onStart:    groundwalk.play()
            onEnd:      groundwalk.stop()
        }

        WPN114.TimeNode //------------------------------------------------------ AUDIO_MISC
        {
            date: sec( 1 )
            onStart:
            {
                waves.play              ( );
                groundwalk.play         ( );
                light_background.play   ( );
            }
        }

        WPN114.TimeNode { date: sec( 20 )
            onStart: { redbirds_1.play(); redbirds_2.play() }}

        // ravens
        WPN114.TimeNode { date: sec(46); onStart: birds.play( "northern-raven1.wav" ) }
        WPN114.TimeNode { date: sec(60); onStart: birds.play( "northern-raven2.wav" ) }
        WPN114.TimeNode { date: sec(68); onStart: birds.play( "northern-raven3.wav" ) }
        WPN114.TimeNode { date: sec(83); onStart: birds.play( "northern-raven4.wav" ) }
        WPN114.TimeNode { date: sec(94); onStart: birds.play( "northern-raven5.wav" ) }

        // marmots
        WPN114.TimeNode { date: min(1.51); onStart: marmots.playRandom() }
        WPN114.TimeNode { date: min(1.53); onStart: marmots.playRandom() }
        WPN114.TimeNode { date: min(1.54); onStart: marmots.playRandom() }
        WPN114.TimeNode { date: min(1.56); onStart: marmots.playRandom() }
        WPN114.TimeNode { date: min(1.565); onStart: marmots.playRandom() }
        WPN114.TimeNode { date: min(1.59); onStart: marmots.playRandom() }

        WPN114.TimeNode //-------------------------------------------------- FADE_OUTS
        {
            after: next_node
            duration: min( 1.42 )

            WPN114.Automation
            {
                target:     cendres_rooms
                property:   "level"
                duration:   min( 1.30 )

                from: 1; to: 0;

                onEnd:
                {
                    necks.stop       ( );
                    ashes.stop       ( );
                    quarre.stop      ( );
                    redbirds_1.stop  ( );
                    redbirds_2.stop  ( );
                    waves.stop       ( );
                    burn.stop        ( );

                    functions.setTimeout(function() {
                        cendres_rooms.active = false
                    }, 3000 );

                }
            }
        }
    }

    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- ORAGE_HAMMER
        {
            id:     interaction_thunder

            title:  "Orage, déclenchement"
            path:   "/stonepath/cendres/interactions/orage"
            module: "basics/GestureHammer.qml"

            description: "Executez le geste décrit ci-dessous pour déclencher un son d'orage."

            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                    root.target_thunder_executor.end();
                    thunder.playRandom();
                }
            }
        }

        Interaction //--------------------------------------------- BOILING_PALM
        {
            id:     interaction_boiling

            title:  "Source volcanique, déclenchement"
            path:   "/stonepath/cendres/interactions/boiling"
            module: "basics/GesturePalm.qml"

            description: "Executez le geste décrit ci-dessous pour déclencher un son."

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                    boiling.play();
                    interaction_boiling.end()
                }
            }
        }

        Interaction //--------------------------------------------- MARMOTTES
        {
            id:     interaction_marmottes

            title:  "Paysages, marmottes"
            path:   "/stonepath/cendres/interactions/marmottes"
            module: "basics/XYTouch.qml"

            description: "Touchez du doigt un endroit de la sphère afin de déclencher
 et de mettre en espace un cri de marmotte."

            mappings: QuMapping
            {
                source: "/modules/xytouch/position2D"
                expression: function(v) {
                    marmots.playRandom();
                    marmots_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }

        Interaction //--------------------------------------------- DRAGON_SPAT
        {
            id:     interaction_dragon

            title:  "Dragon, mise en espace"
            path:   "/stonepath/cendres/interactions/dragon"
            module: "basics/ZRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son dans l'espace."

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    dragon_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }

        Interaction //--------------------------------------------- GROUNDWALK
        {
            id:     interaction_groundwalk

            title:  "Bruits de pas, mise en espace"
            path:   "/stonepath/cendres/interactions/groundwalk"
            module: "basics/ZRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son dans l'espace."

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    groundwalk_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }

        Interaction //--------------------------------------------- BIRDS_TRAJECTORIES
        {
            id: interaction_flying_birds

            title:  "Oiseaux en vol, trajectoires"
            path:   "/stonepath/cendres/interactions/birds"
            module: "quarre/Trajectories.qml"

            description: "Tracez une trajectoire sur la sphère ci-dessous avec votre doigt,
 pendant quelques secondes, puis relachez pour déclencher"

            mappings: [
                QuMapping {
                    source: "/modules/trajectories/trigger"
                    expression: function(v) { birds.playRandom() }},

                QuMapping {
                    source: "/modules/trajectories/position2D"
                    expression: function(v) {
                        birds_source.position = Qt.vector3d(v[0], v[1], 0.5);
                    }
                }
            ]
        }
    }

    WPN114.Rooms //-------------------------------------------------------------------- AUDIO
    {
        id: cendres_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/stonepath/cendres/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.ASHES (1-2)
        {
            exposePath: "/stonepath/cendres/audio/ashes/source"

            fixed:   true
            xspread: 0.25
            yspread: 0.2
            diffuse: 0.47

            WPN114.StreamSampler { id: ashes; loop: true; xfade: 2000
                dBlevel: -2
                exposePath: "/stonepath/cendres/audio/ashes"
                path: "audio/stonepath/cendres/ashes.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 2.REBIRDS_1 (3-4)
        {
            exposePath: "/stonepath/cendres/audio/redbirds-1/source"

            fixed:      true
            xspread:    0.3
            y:          0.9

            WPN114.StreamSampler { id: redbirds_1; loop: true
                exposePath: "/stonepath/cendres/audio/redbirds-1"
                path: "audio/stonepath/cendres/redbirds-1.wav"
            }
        }

        WPN114.StereoSource //----------------------------------------- 3.REBIRDS_2 (5-6)
        {
            exposePath: "/stonepath/cendres/audio/redbirds-2/source"

            fixed:      true
            xspread:    0.3
            y:          0.1

            WPN114.StreamSampler { id: redbirds_2; loop: true
                exposePath: "/stonepath/cendres/audio/redbirds-2"
                path: "audio/stonepath/cendres/redbirds-2.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.LIGHT-BACKGROUND (7-8)
        {
            exposePath: "/stonepath/cendres/audio/light-background/source"

            xspread: 0.25
            yspread: 0.25
            diffuse: 0.5
            fixed: true

            WPN114.Sampler { id: light_background;
                dBlevel: -3
                exposePath: "/stonepath/cendres/audio/light-background"
                path: "audio/stonepath/cendres/light-background.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.BURN (9-10)
        {
            exposePath: "/stonepath/cendres/audio/burn/source"

            xspread: 0.3
            diffuse: 0.7
            fixed: true
            y: 0.1

            WPN114.StreamSampler { id: burn; attack: 1000
                dBlevel: 0
                exposePath: "/stonepath/cendres/audio/burn"
                path: "audio/stonepath/cendres/burn.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -9 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 6.WAVES (11-12)
        {
            exposePath: "/stonepath/cendres/audio/waves/source"

            xspread: 0.42
            diffuse: 0.35
            fixed: true

            WPN114.Sampler { id: waves; loop: true; xfade: 2000
                dBlevel: 6
                exposePath: "/stonepath/cendres/audio/waves"
                path: "audio/stonepath/cendres/waves.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 7.THUNDER (13-14)
        {
            exposePath: "/stonepath/cendres/audio/thunder/source"

            xspread: 0.25
            diffuse: 0.6
            fixed: true
            y: 0.75

            WPN114.MultiSampler { id: thunder;
                dBlevel: 7
                exposePath: "/stonepath/cendres/audio/thunder"
                path: "audio/stonepath/cendres/thunder"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 8.MARMOTS (15-16)
        {
            id:         marmots_source;
            exposePath: "/stonepath/cendres/audio/marmots/source"

            WPN114.MultiSampler { id: marmots;
                dBlevel: 6
                exposePath: "/stonepath/cendres/audio/marmots"
                path: "audio/stonepath/cendres/marmots"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 9.BOILING (17-18)
        {
            exposePath: "/stonepath/cendres/audio/boiling/source"

            xspread: 0.5
            fixed: true
            y: 0.55

            WPN114.Sampler { id: boiling;
                dBlevel: 8
                exposePath: "/stonepath/cendres/audio/boiling"
                path: "audio/stonepath/cendres/boiling.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 10.QUARRE (19-20)
        {
            exposePath: "/stonepath/cendres/audio/quarre/source"

            xspread: 0.42
            diffuse: 0.2
            bias: 0.82
            fixed: true
            y: 0.45

            WPN114.Sampler { id: quarre; attack: 10000; release: 2000;
                dBlevel: 0
                exposePath: "/stonepath/cendres/audio/quarre"
                path: "audio/stonepath/cendres/quarre.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 11.GROUNDWALK (21-22)
        {
            id:         groundwalk_source
            exposePath: "/stonepath/cendres/audio/groundwalk/source"

            WPN114.StreamSampler { id: groundwalk; dBlevel: 14
                exposePath: "/stonepath/cendres/audio/groundwalk"
                path: "audio/stonepath/cendres/groundwalk.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 12.NECKS (25-26)
        {
            exposePath: "/stonepath/cendres/audio/necks/source"

            xspread: 0.15
            fixed: true
            y: 0.6

            WPN114.Sampler { id: necks;
                dBlevel: 12
                exposePath: "/stonepath/cendres/audio/necks"
                path: "audio/stonepath/cendres/necks.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 13.DRAGON (27-28)
        {
            id:         dragon_source
            exposePath: "/stonepath/cendres/audio/dragon/rooms"

            WPN114.StreamSampler { id: dragon; release: 10000
                dBlevel: 10.7
                exposePath: "/stonepath/cendres/audio/dragon"
                path: "audio/stonepath/cendres/dragon.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 14.BIRDS (29-30)
        {
            id:         birds_source
            exposePath: "/stonepath/cendres/audio/birds/rooms"

            WPN114.MultiSampler { id: birds;
                exposePath: "/stonepath/cendres/audio/birds"
                path: "audio/stonepath/cendres/birds"
                WPN114.Fork { target: effects.reverb; dBlevel: 3 }
            }
        }
    }
}
