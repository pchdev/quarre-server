import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    WPN114.Node
    {
        path: "/interactions/stonepath/diaclases/setup"
        type: WPN114.Type.Impulse

        onValueReceived:
        {
            instruments.kaivo_1.active = true;
            instruments.kaivo_2.active = false;
            instruments.kaivo_1.setPreset("spring");
        }
    }

    Item //-------------------------------------------------------------------- INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- SPRING_LOW
        {
            id:     interaction_spring_low

            title:  "Gong primitif, déclenchements (1)"
            path:   "/stonepath/diaclases/spring-low"
            module: "basics/GesturePalm.qml"

            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (graves)."

            length: 80
            countdown:  15

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
            path:   "/stonepath/diaclases/spring-hi"
            module: "basics/GesturePalm.qml"

            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (aigues)."

            length: 80
            countdown:  15

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
            path:   "/stonepath/diaclases/spring-timbre"
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
            path:   "/stonepath/diaclases/spring-low-2"
            module: "basics/GesturePalm.qml"

            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (graves)."

            length: 80
            countdown:  10

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
            path:   "/stonepath/diaclases/spring-hi-2"
            module: "basics/GesturePalm.qml"

            description: "Exécutez le geste décrit ci-dessous afin de déclencher des notes (aigues)."

            length: 80
            countdown:  10

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
            path:   "/stonepath/diaclases/spring-timbre-2"
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
            path:   "/stonepath/diaclases/smoke"
            module: "basics/ZRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son de combustion dans l'espace."

            length: 155
            countdown:  15

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) { smoke_source.position = v }
            }
        }
    }

    WPN114.Rooms
    {
        id: diaclases_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/audio/stonepath/diaclases/rooms"

        WPN114.StereoSource //----------------------------------------- 1.STONEWATER (1-2)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.5
            y: 0.25

            exposePath: "/audio/stonepath/diaclases/stonewater/source"

            WPN114.StreamSampler { id: stonewater;
                exposePath: "/audio/stonepath/diaclases/stonewater"
                path: "audio/stonepath/diaclases/stonewater.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.HARMONICS (3-4)
        {            
            fixed: true
            xspread: 0.25
            diffuse: 0.5
            y: 0.25

            exposePath: "/audio/stonepath/diaclases/harmonics/source"

            WPN114.StreamSampler { id: harmonics;
                exposePath: "/audio/stonepath/diaclases/harmonics"
                path: "audio/stonepath/diaclases/harmonics.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.DRONE (5-6)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.6
            y: 0.85

            exposePath: "/audio/stonepath/diaclases/drone/source"

            WPN114.StreamSampler { id: drone;
                exposePath: "/audio/stonepath/diaclases/drone"
                path: "audio/stonepath/diaclases/drone.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 4.SMOKE (7-8)
        {
            id: smoke_source;
            exposePath: "/audio/stonepath/diaclases/smoke/source"

            WPN114.Sampler { id: smoke;
                exposePath: "/audio/stonepath/diaclases/smoke"
                path: "audio/stonepath/diaclases/smoke.wav" }
        }
    }
}
