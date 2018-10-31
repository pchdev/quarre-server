import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../.."

Item
{
    id: root
    signal next();
    property alias scenario: scenario

    WPN114.TimeNode
    {
        id:             scenario
        source:         audio_stream
        exposePath:     "/woodpath/carre/scenario"

        onStart:
        {
            instruments.kaivo_1.active = true;
            instruments.kaivo_2.active = true;
            instruments.rooms.active = true;
            client_manager.notifyScene("carre");
        }

        // 1.SOFT ------------------------------------------------------------

        InteractionExecutor
        {
            target:     interaction_bell_low_1
            date:       sec( 5 )
            countdown:  sec( 15 )
            length:     min( 1.20 )

            onStart:
            {
                instruments.kaivo_1.setPreset("niwood");
                instruments.kaivo_2.setPreset("insects");
            }
        }

        InteractionExecutor
        {
            target:     interaction_bell_hi_1
            date:       sec( 5.1 )
            countdown:  sec( 15 )
            length:     min( 1.20 )
        }

        InteractionExecutor
        {
            target:     interaction_bell_timbre
            date:       sec( 5.2 )
            countdown:  sec( 15 )
            length:     min( 1.20 )
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
            after:      interaction_bell_low_1
            target:     interaction_bell_low_2
            date:       sec( 5 )
            countdown:  sec( 10 )
            length:     sec( 80 )

            onStart:    instruments.kaivo_1.set("env1_attack", 0);
        }

        InteractionExecutor
        {
            after:      interaction_bell_hi_1
            target:     interaction_bell_hi_2
            date:       sec( 5.1 )
            countdown:  sec( 10 )
            length:     sec( 80 )
        }

        InteractionExecutor
        {
            after:      interaction_bell_low_1
            target:     interaction_bell_timbre
            date:       sec( 5.2 )
            countdown:  sec( 10 )
            length:     sec( 80 )
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

                    instruments.kaivo_1.noteOn(0, rdm, 10);
                    functions.setTimeout(function(){
                        instruments.kaivo_1.noteOff(0, rdm, 10);
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
            mappings: interaction_bell_low_1.mappings;
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

                    instruments.kaivo_1.noteOn(0, rdm, 10);
                    functions.setTimeout(function() {
                        instruments.kaivo_1.noteOff(0, rdm, 10);
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
            mappings: interaction_bell_hi_1.mappings;
        }

        Interaction //------------------------------------------------- NIWOOD-TIMBRE
        {
            id: interaction_bell_timbre

            title: "Cloches primitives, timbre"
            module: "basics/XYZRotation.qml"

            description: "Faites pivoter l'appareil dans ses axes de rotation
 pour manipuler la brillance (Y) et la hauteur (X) de l'instrument déclenché par vos partenaires."

            // niwood timbre (brightness 0-0.5, position, body pitch)
            mappings: QuMapping
            {
                source: "/modules/xyzrotation/data"
                expression: function(v)
                {
                    var y = Math.abs(v[1])/180;
                    var x = Math.abs(v[0])/90;
                    var z = Math.abs(v[2])/360;

                    instruments.kaivo_1.set("res_brightness", y*0.5);
                    instruments.kaivo_1.set("res_position", z);
                    instruments.kaivo_1.set("body_pitch", x);
                }
            }
        }       

        Interaction //------------------------------------------------- INSECTS
        {
            id: interaction_insects

            title: "Insectes, déclenchement"
            module: "quarre/Insects.qml"

            description: "Agitez fermement votre appareil pour ajouter des sons d'insectes,
 orientez votre téléphone tout autour de vous pour les déplacer"

            mappings:
                [
                QuMapping // ---------------------------------------------- note add/erase
                {
                    source: "/modules/insects/trigger"
                    expression: function(v) {

                        if ( v )
                        {

                        }

                        else instruments.kaivo_2.allNotesOff();
                    }
                },

                QuMapping // ---------------------------------------------- x-pitch mapping
                {
                    source: "/modules/xrotation/normalized"
                    expression: function(v) {
                        instruments.kaivo_2.set("gran_pitch", v);
                    }
                },

                QuMapping // ---------------------------------------------- rotation mapping
                {
                    source: "/modules/zrotation/position2D"
                    expression: function(v) {
                        instruments.kaivo_2_source.position = Qt.vector3d(v[0], v[1], 0.5);
                    }
                }
            ]
        }
    }
}
