import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    id: root
    property alias rooms: diaclases_rooms
    property alias scenario: scenario
    property real spring_attack: 0

    onSpring_attackChanged: instruments.kaivo_1.set("env1_attack", spring_attack);

    signal next()

    WPN114.TimeNode
    {
        id: scenario
        source: audio_stream
        exposePath: "/stonepath/diaclases/scenario"

        duration: -1

        onStart:
        {
            instruments.rooms.active    = true
            instruments.kaivo_1.active  = true
            instruments.kaivo_1.dBlevel = -4
            instruments.kaivo_2.active  = false

            stonewater.play();
            diaclases_rooms.active = true
            client_manager.notifyScene("diaclases");
        }

        // always wait a little bit before changing presets after setting active
        WPN114.TimeNode { date: sec(20); onStart: instruments.kaivo_1.setPreset("spring") }
        WPN114.TimeNode { date: sec(13); onStart: { harmonics.play(); smoke.play() }}
        WPN114.TimeNode { date: sec(55); onStart: { drone.play() }}

        // FIRST BATCH OF INTERACTIONS ---------------------------------------------------------
        InteractionExecutor
        {
            id:         spl1
            target:     interaction_spring_low
            date:       sec( 20 )
            countdown:  sec( 15 )
            length:     min( 1.20 )
        }

        InteractionExecutor
        {
            target:     interaction_spring_high;
            date:       sec( 20 )
            countdown:  sec( 15 )
            length:     min( 1.20 )
        }

        InteractionExecutor
        {
            target:     interaction_spring_timbre_1;
            date:       sec( 20 )
            length:     min( 1.20 )
            countdown:  sec( 15 )
        }

        InteractionExecutor
        {
            target:     interaction_smoke_spat
            date:       sec( 35 )
            countdown:  sec( 15 )
            length:     min( 1.35 )
        }

        // SECOND BATCH OF INTERACTIONS -------------------------------------------------------

        InteractionExecutor
        {
            target:     interaction_spring_low_2
            after:      spl1
            date:       sec( 2 )
            countdown:  sec( 10 )
            length:     min( 1.20 )
        }

        InteractionExecutor
        {
            target:     interaction_spring_high_2
            after:      spl1
            date:       sec( 2.1 )
            countdown:  sec( 10 )
            length:     min( 1.20 )
        }

        InteractionExecutor
        {
            target:     interaction_spring_timbre_2
            after:      spl1
            date:       sec( 2.2 )
            countdown:  sec( 10 )
            length:     min( 1.20 )

            onEnd:      root.next()
        }

        // AUTOMATIONS ------------------------------------------------------------------------

        WPN114.Automation
        {
            after:      spl1;
            target:     root
            property:   "spring_attack"
            date:       sec(22)
            duration:   min(1)

            from: 0; to: 0.6;
        }

        // VERB
        WPN114.Automation
        {
            after: spl1; date: min(1.14)
            target: instruments.kaivo_1
            property: "dBlevel"
            from: -4; to: -96;
            duration: sec(20)
        }

        WPN114.Automation
        {
            after: spl1
            date: min(1.14)
            target: drone
            property: "level"
            from: 1; to: 0;
            duration: min(1)
        }

        WPN114.Automation
        {
            after: spl1
            date: min(1.14)
            target: harmonics
            property: "level"
            from: 1; to: 0;
            duration: min(1)

            onEnd:
            {
                diaclases_rooms.active = false
                instruments.kaivo_1.allNotesOff();
                instruments.kaivo_1.active = false;
                instruments.rooms.active = false;
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
            path:   "/stonepath/diaclases/interactions/spring-hi"
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
            path:   "/stonepath/diaclases/interactions/spring-timbre"
            module: "basics/XYZRotation.qml"

            description: "Faites pivoter l'appareil dans ses axes de rotation
 pour manipuler la brillance (Y) et la hauteur (X) de l'instrument déclenché par vos partenaires."

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v)
                {
                    var y = Math.abs(v[1])/180;
                    var x = Math.abs(v[0])/90;
                    instruments.kaivo_1.set("res_brightness", y);
                    instruments.kaivo_1.set("res_pitch", x);
                }
            }
        }
        Interaction //--------------------------------------------- SPRING_LOW
        {
            id:     interaction_spring_low_2

            title:  "Gong primitif, percussif (1)"
            path:   "/stonepath/diaclases/interactions/spring-low-2"
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
            path:   "/stonepath/diaclases/interactions/spring-hi-2"
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
            path:   "/stonepath/diaclases/interactions/spring-timbre-2"
            module: "basics/XYZRotation.qml"

            description: "Faites pivoter l'appareil dans ses axes de rotation pour
 manipuler la brillance (Y) et la hauteur (X) de l'instrument déclenché par vos partenaires."

            mappings: QuMapping
            {
                source: "/sensors/rotation/xyz/data"
                expression: function(v) {
                    var y = Math.abs(v[1])/180;
                    var x = Math.abs(v[0])/90;
                    instruments.kaivo_1.set("res_brightness", y);
                    instruments.kaivo_1.set("res_pitch", x);
                }
            }
        }

        Interaction //--------------------------------------------- SMOKE_SPAT
        {
            id:     interaction_smoke_spat

            title:  "Combustions, mise en espace"
            path:   "/stonepath/diaclases/interactions/smoke"
            module: "basics/ZRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son de combustion dans l'espace."

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    smoke_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }
    }

    WPN114.Rooms
    {
        id: diaclases_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/stonepath/diaclases/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.STONEWATER (1-2)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.5
            y: 0.25

            exposePath: "/stonepath/diaclases/audio/stonewater/source"

            WPN114.StreamSampler { id: stonewater;
                exposePath: "/stonepath/diaclases/audio/stonewater"
                path: "audio/stonepath/diaclases/stonewater.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.HARMONICS (3-4)
        {            
            fixed: true
            xspread: 0.25
            diffuse: 0.5
            y: 0.25

            exposePath: "/stonepath/diaclases/audio/harmonics/source"

            WPN114.StreamSampler { id: harmonics; loop: true; xfade: 2000
                exposePath: "/stonepath/diaclases/audio/harmonics"
                path: "audio/stonepath/diaclases/harmonics.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.DRONE (5-6)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.6
            y: 0.85

            exposePath: "/stonepath/diaclases/audio/drone/source"

            WPN114.StreamSampler { id: drone; loop: true; xfade: 2000
                exposePath: "/stonepath/diaclases/audio/drone"
                path: "audio/stonepath/diaclases/drone.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 4.SMOKE (7-8)
        {
            id: smoke_source;
            exposePath: "/stonepath/diaclases/audio/smoke/source"

            WPN114.Sampler { id: smoke;
                exposePath: "/stonepath/diaclases/audio/smoke"
                path: "audio/stonepath/diaclases/smoke.wav" }
        }
    }
}
