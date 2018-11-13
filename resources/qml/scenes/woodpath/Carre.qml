import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../../engine"

Scene
{
    id: root
    property real env_attack: 0
    onEnv_attackChanged: instruments.kaivo_1.set("env1_attack", env_attack);

    scenario: WPN114.TimeNode
    {
        source: audiostream
        parentNode: parent.scenario
        duration: WPN114.TimeNode.Infinite

        onStart:
        {
            instruments.kaivo_1.dBlevel = -4
            instruments.kaivo_1.active = true
            instruments.kaivo_2.active = false;
            instruments.rooms.active = true;
            alpine_swift.play();

        }
        onEnd:
        {
            instruments.kaivo_1.allNotesOff();
            functions.setTimeout(function() {
                instruments.kaivo_1.active = false;
                instruments.rooms.active = false;
            }, 1000 );
        }

        // ================================================================= 1.SOFT

        InteractionExecutor
        {
            id:         interaction_bell_low_1_ex
            target:     interaction_bell_low_1
            date:       sec( 5 )
            countdown:  sec( 15 )
            length:     min( 1.20 )

            WPN114.TimeNode { date: sec( 45 ); onStart: harmonics.play() }

            onStart:
            {
                instruments.kaivo_1.setPreset( instruments.niwood );
                instruments.kaivo_1.set("env1_attack", 0.6)
                spring.play();
                groundnoise.play();
                insects.play();
            }

            InteractionExecutor
            {
                target:     interaction_bell_hi_1
                countdown:  sec( 15 )
                length:     min( 1.20 )

                InteractionExecutor
                {
                    target:     interaction_swifts
                    countdown:  sec( 15 )
                    length:     min( 1.20 )

                    // TODO: only stop if not dispatched

                    onBegin: alpine_swift.stop();
                    //                    onEnd: alpine_swift.play();
                }
            }

            onEnd: quarre.play();
        }

        InteractionExecutor
        {
            target:     interaction_insects
            date:       sec( 20 )
            countdown:  sec( 15 )
            length:     min( 2.20 )
        }

        // 2.PERCUSSIVE -------------------------------------------------------

        InteractionExecutor
        {
            after:      interaction_bell_low_1_ex
            target:     interaction_bell_low_2
            date:       sec( 2 )
            countdown:  sec( 5 )
            length:     sec( 80 )

            onStart:    instruments.kaivo_1.set( "env1_attack", 0 );

            InteractionExecutor
            {
                id:         interaction_bell_hi_2_ex
                target:     interaction_bell_hi_2
                countdown:  sec( 5 )
                length:     sec( 80 )

                InteractionExecutor
                {
                    id:         interaction_swifts_2_ex
                    target:     interaction_swifts
                    countdown:  sec( 5 )
                    length:     sec( 80 )

                    onEnd: alpine_swift.play();
                }
            }

            WPN114.TimeNode { date: sec( 82 ); onStart: next(); }

            WPN114.Automation
            {
                date:       sec( 20 )
                target:     root
                property:   "env_attack"
                duration:   sec( 35 )
                from:       0
                to:         0.6
            }

            WPN114.Automation
            {
                date:       sec( 65 )
                target:     instruments.kaivo_1
                property:   "level"
                duration:   sec( 25 )

                from: instruments.kaivo_1.level; to: 0
            }
        }

        WPN114.Automation
        {
            after:      interaction_bell_hi_2_ex
            target:     rooms
            property:   "level"
            duration:   sec( 45 )

            from: rooms.level; to: 0;
            onEnd: scenario.end();
        }
    }

    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //------------------------------------------------- NIWOOD-LOW
        {
            id: interaction_bell_low_1
            title: "Cloches primitives, déclenchements (1)"
            module: "basics/GesturePalm.qml"

            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (graves)."

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v)
                {
                    var rdm = Math.floor(Math.random()*14+40);

                    instruments.kaivo_1.noteOn(0, rdm, 60);
                    functions.setTimeout(function(){
                        instruments.kaivo_1.noteOff(0, rdm, 60);
                    }, 5000);
                }
            }
        }

        Interaction
        {
            id: interaction_bell_low_2
            title: "Cloches primitives, percussif (1)"
            module: "basics/GestureHammer.qml"

            description: interaction_bell_low_1.description;

            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                    var rdm = Math.floor(Math.random()*14+45);

                    instruments.kaivo_1.noteOn(0, rdm, 120);
                    functions.setTimeout(function(){
                        instruments.kaivo_1.noteOff(0, rdm, 120);
                    }, 5000);
                }
            }
        }

        Interaction //------------------------------------------------- NIWOOD-HI
        {
            id: interaction_bell_hi_1
            title: "Cloches primitives, déclenchements (2)"
            module: "basics/GesturePalm.qml"

            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (aigues)."

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                    var rdm = Math.floor(Math.random()*14+60);

                    instruments.kaivo_1.noteOn(0, rdm, 60);
                    functions.setTimeout(function() {
                        instruments.kaivo_1.noteOff(0, rdm, 60);
                    }, 5000);
                }
            }
        }

        Interaction
        {
            id: interaction_bell_hi_2
            title: "Cloches primitives, percussif (2)"
            module: "basics/GestureHammer.qml"

            description: interaction_bell_hi_1.description;
            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                    var rdm = Math.floor(Math.random()*14+60);

                    instruments.kaivo_1.noteOn(0, rdm, 120);
                    functions.setTimeout(function(){
                        instruments.kaivo_1.noteOff(0, rdm, 120);
                    }, 5000);
                }
            }
        }

        Interaction //------------------------------------------------- NIWOOD-TIMBRE
        {
            id: interaction_swifts

            title: "Martinets, trajectoires"
            module: "quarre/Trajectories.qml"

            description:
                "Tracez une trajectoire sur la sphère ci-dessous avec votre doigt,
                 pendant quelques secondes, puis relachez pour déclencher"

            mappings: [
                QuMapping {
                    source: "/modules/trajectories/trigger"
                    expression: function(v) { multiswifts.playRandom() }},

                QuMapping {
                    source: "/modules/trajectories/position2D"
                    expression: function(v) {
                        multiswifts_source.position = Qt.vector3d(v[0], v[1], 0.5);
                    }
                }
            ]
        }

        Interaction //------------------------------------------------- INSECTS
        {
            id: interaction_insects

            title: "Insectes, mise en espace"
            path:   "/woodpath/carre/interactions/insects"
            module: "basics/ZRotation.qml"

            description: "Gardez votre appareil à plat, horizontalement, puis orientez-le
 tout autour de vous pour identifier et déplacer un son dans l'espace sonore."

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    insects_source.position  = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }

        Interaction
        {
            id:         interaction_carres
            title:      "Carres, déclenchement"
            module:     "basics/GestureHammer.qml"
            path:       "/woodpath/carre/interactions/carres"

            description: "Executez le geste décrit ci-dessous pour déclencher un son"

            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                }
            }

        }
    }

    WPN114.StereoSource //----------------------------------------- SPRING
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.5
        yspread: 0.25

        exposePath: fmt("audio/spring/source")

        WPN114.StreamSampler { id: spring; loop: true; xfade: 3000
            exposePath: fmt("audio/spring")
            path: "audio/introduction/spring.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.MonoSource // ------------------------------------------ MULTISWIFTS
    {
        id: multiswifts_source
        parentStream: rooms

        WPN114.MultiSampler
        {
            id: multiswifts
            exposePath: fmt("audio/multiswifts")
            path: "audio/woodpath/carre/swifts"

            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.StereoSource //----------------------------------------- ALPINE_SWIFT
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.5
        yspread: 0.25

        exposePath: fmt("audio/swift/source")

        WPN114.StreamSampler { id: alpine_swift;
            loop: true; xfade: 3000; release: 3000
            exposePath: fmt("audio/swift")
            path: "audio/woodpath/carre/swift.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.StereoSource //----------------------------------------- GROUNDNOISE
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.5
        xspread: 0.25

        exposePath: fmt("audio/groundnoise/source")

        WPN114.StreamSampler { id: groundnoise; loop: true; xfade: 3000
            exposePath: fmt("audio/groundnoise")
            path: "audio/woodpath/carre/groundnoise.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -6 }
        }
    }

    WPN114.StereoSource //----------------------------------------- QUARRE
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.25
        xspread: 0.5

        exposePath: fmt("audio/quarre/source")

        WPN114.StreamSampler { id: quarre; loop: true; xfade: 4000
            exposePath: fmt("audio/quarre")
            path: "audio/woodpath/carre/quarre.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -6 }
        }
    }

    WPN114.MonoSource //----------------------------------------- INSECTS
    {
        id: insects_source
        parentStream: rooms
        exposePath: fmt("audio/insects/source")

        WPN114.StreamSampler { id: insects; loop: true; xfade: 3000
            dBlevel: 6
            exposePath: fmt("audio/insects")
            path: "audio/woodpath/carre/insects.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -6 }
        }
    }

    WPN114.StereoSource //----------------------------------------- HARMONICS
    {
        id: harmonics_source
        parentStream: rooms
        fixed: true
        yspread: 0.4

        exposePath: fmt("audio/harmonics/source")

        WPN114.StreamSampler { id: harmonics; loop: true; xfade: 3000
            exposePath: fmt("audio/harmonics")
            path: "audio/woodpath/carre/harmonics.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -3 }
        }
    }

    //            WPN114.MonoSource //----------------------------------------- RAVENS
    //            {
    //                id:         ravens_source
    //                exposePath: fmt("audio/ravens/rooms"

    //                WPN114.MultiSampler { id: ravens;
    //                    exposePath: fmt("audio/ravens"
    //                    path: "audio/woodpath/carre/ravens"
    //                    WPN114.Fork { target: effects.reverb; dBlevel: 3 }
    //                }
    //            }
}
