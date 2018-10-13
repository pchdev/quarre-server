import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    Item
    {
        id: interactions

        Interaction //--------------------------------------------- STRING_SWEEP
        {
            id:     interaction_string_sweep

            title:  "Cordes, déclenchement"
            path:   "/stonepath/ammon/strings"
            module: "quarre/Strings.qml"

            description: "Frottez les cordes avec votre doigt au fur
 et à mesure de leur apparition"

            length: 360
            countdown: 10

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- INHARM_SYNTH
        {
            id:     interaction_inharm_synth

            title:  "Inharmonie"
            path:   "/stonepath/ammon/inharmonic"
            module: "quarre/JomonPalmZ.qml"

            description: "Approchez et maintenez la paume de votre main
 à quelques centimètres de l'écran pour produire une nappe inharmonique,
 retirez-la pour la faire disparaître. Préférez les notes longues."

            length: 300
            countdown: 10

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- STRINGS_TIMBRE
        {
            id:     interaction_strings_timbre

            title:  "Guitare primitive, timbre"
            path:   "/stonepath/ammon/strings-timbre"
            module: "basics/XYZRotation.qml"

            description: "Faites pivoter l'appareil dans ses axes de rotation pour manipuler
 la brillance (axe Y) et la hauteur (axe X) de l'instrument déclenché par votre partenaire."

            length: 360
            countdown: 10

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- BELLS
        {
            id:     interaction_bells

            title:  "Cloches, pré-rythmiques"
            path:   "/stonepath/ammon/bells"
            module: "quarre/AmmonBells.qml"

            description: "Exécutez un geste de frappe verticale pour
 déclencher des sons de cloches"

            length: 360
            countdown: 10

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }
    }

    WPN114.Rooms
    {
        id: ammon_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        WPN114.StereoSource //----------------------------------------- 1.FOOTSTEPS (1-2)
        {            
            fixed: true
            xspread: 0.3
            diffuse: 0.1
            y: 0.1

            exposePath: "/audio/stonepath/ammon/footsteps/source"

            WPN114.Sampler { id: footsteps;
                exposePath: "/audio/stonepath/ammon/footsteps"
                path: "audio/stonepath/ammon/foosteps.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.BROKEN-RADIO (3-4)
        {
            fixed: true
            xspread: 0.05
            y: 0.8

            exposePath: "/audio/stonepath/ammon/broken-radio/source"

            WPN114.Sampler { id: broken_radio;
                exposePath: "/audio/stonepath/ammon/broken-radio"
                path: "audio/stonepath/ammon/broken-radio.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.HARMONICS (5-6)
        {
            fixed: true
            xspread: 0.3
            diffuse: 0.3
            y: 0.75

            exposePath: "/audio/stonepath/ammon/harmonics/source"

            WPN114.StreamSampler { id: harmonics;
                exposePath: "/audio/stonepath/ammon/harmonics"
                path: "audio/stonepath/ammon/harmonics.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.WIND (7-8)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.85

            exposePath: "/audio/stonepath/ammon/wind/source"

            WPN114.Sampler { id: wind;
                exposePath: "/audio/stonepath/ammon/wind"
                path: "audio/stonepath/ammon/wind.wav" }
        }
    }
}
