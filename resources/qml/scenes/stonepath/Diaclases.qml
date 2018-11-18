import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../../engine"
import ".."

Scene
{
    id: root

    property real spring_attack: 0
    property alias interaction_spring_low : interaction_spring_low
    property alias interaction_spring_low_2: interaction_spring_low_2
    property alias interaction_spring_timbre: interaction_spring_timbre_1

    onSpring_attackChanged: instruments.kaivo_1.set("env1_attack", spring_attack);

    scenario: WPN114.TimeNode
    {
        source: audiostream
        parentNode: parent.scenario
        duration: WPN114.TimeNode.Infinite

        onStart:
        {
            instruments.rooms.active    = true
            instruments.kaivo_1.active  = true
            instruments.kaivo_1.dBlevel = -4
            stonewater.play();
        }

        // always wait a little bit before changing presets after setting active
        WPN114.TimeNode { date: sec(20); onStart: instruments.kaivo_1.setPreset(instruments.spring) }
        WPN114.TimeNode { date: sec(13); onStart: { harmonics.play(); smoke.play() }}
        WPN114.TimeNode { date: sec(55); onStart: { drone.play() }}

        // FIRST BATCH OF INTERACTIONS ---------------------------------------------------------
        InteractionExecutor
        {
            id:         interaction_spring_low_ex
            target:     interaction_spring_low
            date:       sec( 30 )
            countdown:  sec( 15 )
            length:     min( 1.20 )

            InteractionExecutor
            {
                target:     interaction_spring_high;
                countdown:  sec( 15 )
                length:     min( 1.20 )
            }

            InteractionExecutor
            {
                target:     interaction_spring_timbre_1;
                length:     min( 1.20 )
                countdown:  sec( 15 )
            }
        }

        InteractionExecutor
        {
            target:     interaction_smoke_spat
            date:       sec( 35 )
            countdown:  sec( 15 )
            length:     min( 2.45 )
        }

        // SECOND BATCH OF INTERACTIONS -------------------------------------------------------

        InteractionExecutor
        {
            target:      interaction_spring_low_2
            after:       interaction_spring_low_ex
            date:        sec( 1 )
            countdown:   sec( 10 )
            length:      min( 1.20 )

            InteractionExecutor
            {
                target:     interaction_spring_high_2
                countdown:  sec( 10 )
                length:     min( 1.20 )
            }

            InteractionExecutor
            {
                target:     interaction_spring_timbre_2
                countdown:  sec( 10 )
                length:     min( 1.20 )

                WPN114.TimeNode { date: min( 1.15 ); onStart: root.next() }
            }
        }

        // AUTOMATIONS ------------------------------------------------------------------------

        WPN114.Automation
        {
            after:      interaction_spring_low_ex;
            target:     root
            property:   "spring_attack"
            date:       sec( 22 )
            duration:   sec( 35 )

            from: 0; to: 0.6;
        }

        // VERB
        WPN114.Automation
        {
            after: interaction_spring_low_ex
            date: min( 1.14 )
            target: instruments.kaivo_1
            property: "dBlevel"
            from: instruments.kaivo_1.dBlevel; to: -96;
            duration: sec( 35 )
        }

        WPN114.Automation
        {
            after:      interaction_spring_low_ex
            target:     rooms
            date:       min( 1.14 )
            property:   "level"
            from:       rooms.level; to: 0;
            duration:   sec( 70 )

            onEnd:
            {
                scenario.end()

                instruments.kaivo_1.allNotesOff();

                functions.setTimeout(function() {
                    instruments.kaivo_1.active = false;
                    instruments.rooms.active = false;
                }, 2000 );
            }
        }
    }

    Item //-------------------------------------------------------------------- INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- SPRING_LOW
        {
            id:     interaction_spring_low
            title:  "Gong primitif, déclenchements (1)"
            path:   "/stonepath/diaclases/interactions/spring-low"
            module: "basics/GesturePalm.qml"
            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (graves)."

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v)
                {
                    var rdm = Math.floor(Math.random()*14+40);

                    instruments.kaivo_1.noteOn(0, rdm, 10);
                    functions.setTimeout(function(){
                        instruments.kaivo_1.noteOff(0, rdm, 10);
                    }, 5000);
                }
            }
        }

        Interaction //--------------------------------------------- SPRING_HI
        {
            id:     interaction_spring_high
            title:  "Gong primitif, déclenchements (2)"
            module: "basics/GesturePalm.qml"
            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (aigues)."

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                    var rdm = Math.floor(Math.random()*14+60);

                    instruments.kaivo_1.noteOn(0, rdm, 10);
                    functions.setTimeout(function() {
                        instruments.kaivo_1.noteOff(0, rdm, 10);
                    }, 5000);
                }
            }
        }

        Interaction //--------------------------------------------- SPRING_TIMBRE_1
        {
            id:     interaction_spring_timbre_1
            title:  "Gong primitif, timbre"
            module: "basics/XYZRotation.qml"
            description: "Faites pivoter l'appareil dans ses axes de rotation pour manipuler la brillance (Y) et la hauteur (X) de l'instrument déclenché par vos partenaires."

            mappings: QuMapping
            {
                source: "/modules/xyzrotation/data"
                expression: function(v) {
                    var y = Math.abs(v[1])/180;
                    var x = v[0]/90;
                    instruments.kaivo_1.set("res_brightness", y);
                    instruments.kaivo_1.set("res_pitch", x*0.05+0.5);
                }
            }
        }
        Interaction //--------------------------------------------- SPRING_LOW
        {
            id:     interaction_spring_low_2
            title:  "Gong primitif, percussif (1)"
            module: "basics/GestureHammer.qml"
            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (graves)."

            onInteractionNotify: instruments.kaivo_1.set("env1_attack", 0)

            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                    var rdm = Math.floor(Math.random()*14+45);

                    instruments.kaivo_1.noteOn(0, rdm, 50);
                    functions.setTimeout(function(){
                        instruments.kaivo_1.noteOff(0, rdm, 50);
                    }, 5000);
                }
            }
        }

        Interaction //--------------------------------------------- SPRING_HI
        {
            id:     interaction_spring_high_2
            title:  "Gong primitif, percussif (2)"
            module: "basics/GestureHammer.qml"
            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (aigues)."

            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                    var rdm = Math.floor(Math.random()*14+60);

                    instruments.kaivo_1.noteOn(0, rdm, 50);
                    functions.setTimeout(function(){
                        instruments.kaivo_1.noteOff(0, rdm, 50);
                    }, 5000);
                }
            }
        }

        Interaction //--------------------------------------------- SPRING_TIMBRE_1
        {
            id:     interaction_spring_timbre_2
            title:  "Gong primitif, timbre (2)"
            module: "basics/XYZRotation.qml"
            description: "Faites pivoter l'appareil dans ses axes de rotation pour manipuler la brillance (Y) et la hauteur (X) de l'instrument déclenché par vos partenaires."

            mappings: QuMapping
            {
                source: "/modules/xyzrotation/data"
                expression: function(v) {
                    var y = Math.abs(v[1])/180;
                    var x = v[0]/90;
                    instruments.kaivo_1.set("res_brightness", y);
                    instruments.kaivo_1.set("res_pitch", x*0.05+0.5);
                }
            }
        }

        Interaction //--------------------------------------------- SMOKE_SPAT
        {
            id:     interaction_smoke_spat
            title:  "Combustions, mise en espace"
            module: "basics/ZRotation.qml"
            description: "Orientez votre appareil horizontalement, à 360 degrés autour de vous pour identifier et déplacer le son de combustion dans l'espace."

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    smoke_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }
    }


    WPN114.StereoSource //----------------------------------------- 1.STONEWATER (1-2)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.4
        diffuse: 0.2
        y: 0.5

        exposePath: fmt("audio/stonewater/source");

        WPN114.StreamSampler { id: stonewater;
            exposePath: fmt("audio/stonewater");
            path: "audio/stonepath/diaclases/stonewater.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 2.HARMONICS (3-4)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.25
        diffuse: 0.2
        y: 0.25

        exposePath: fmt("audio/harmonics/source")

        WPN114.StreamSampler { id: harmonics; loop: true; xfade: 2000
            exposePath: fmt("audio/harmonics")
            path: "audio/stonepath/diaclases/harmonics.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 3.DRONE (5-6)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.25
        diffuse: 0.2
        y: 0.85

        exposePath: fmt("audio/drone/source")

        WPN114.StreamSampler { id: drone; loop: true; xfade: 2000
            exposePath: fmt("audio/drone")
            path: "audio/stonepath/diaclases/drone.wav" }
    }

    WPN114.MonoSource //----------------------------------------- 4.SMOKE (7-8)
    {
        id: smoke_source;
        parentStream: rooms
        exposePath: fmt("audio/smoke/source")

        WPN114.Sampler { id: smoke; loop: true; xfade: 3000
            exposePath: fmt("audio/smoke")
            path: "audio/stonepath/diaclases/smoke.wav" }
    }
}
