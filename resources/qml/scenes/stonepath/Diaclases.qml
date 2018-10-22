import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    property alias rooms: diaclases_rooms

    WPN114.Node
    {
        path: "/stonepath/diaclases/interactions/spring_attack"
        type: WPN114.Type.Float
        onValueReceived: instruments.kaivo_1.set("env1_attack", newValue);
    }

    WPN114.Node
    {
        path: "/stonepath/diaclases/active"
        type: WPN114.Type.Bool

        onValueReceived:
        {
            if ( newValue )
            {
                instruments.kaivo_2.active = false;
                instruments.absynth.active = false;
                effects.amplitube.active = false;
            }

            instruments.kaivo_1.active = newValue;
            diaclases_rooms.active = newValue;
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

            length: 80
            countdown:  15

            onInteractionNotify: instruments.kaivo_1.programChange(0, 37)

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

            length: 80
            countdown:  15

            onInteractionNotify: instruments.kaivo_1.programChange(0, 37)

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

            length: 80
            countdown:  15

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

            length: 80
            countdown:  10

            onInteractionNotify:
            {
                instruments.kaivo_1.programChange(0, 37)
                instruments.kaivo_1.set("env1_attack", 0)
            }

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

            length: 80
            countdown:  10

            onInteractionNotify:
            {
                instruments.kaivo_1.programChange(0, 37)
                instruments.kaivo_1.set("env1_attack", 0)
            }

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

            length: 80
            countdown:  10

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

            length: 155
            countdown:  15

            onInteractionNotify:    smoke.play();
            onInteractionEnd:       smoke.stop();

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

            WPN114.StreamSampler { id: harmonics;
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

            WPN114.StreamSampler { id: drone;
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
