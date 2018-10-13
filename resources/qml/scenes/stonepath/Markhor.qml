import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    Item
    {
        id: interactions

        Interaction //--------------------------------------------- CLOCK_BELLS
        {
            id:     interaction_clock_bells

            title:  "Cloches, pré-rythmiques"
            path:   "/stonepath/markhor/clock-bells"
            module: "quarre/VareRainbells.qml"

            description: "Passez la main devant l'appareil pour ajouter et changer
 les notes des cloches, pivotez-le doucement dans n'importe quel axe de rotation
 afin de changer leurs propriétés."

            length: 45
            countdown:  15

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_GRANULAR
        {
            id:     interaction_granular_models

            title:  "Impulsions (essais)"
            path:   "/stonepath/markhor/granular-1"
            module: "quarre/MarkhorGranular.qml"

            description: "Manipulez les sliders afin d'altérer les propriétés d'excitation
 des résonateurs. Choisissez le son qui vous convient. Attention au temps !"

            length: 60
            countdown:  15

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS
        {
            id:     interaction_resonators_1

            title:  "Résonances (essais)"
            path:   "/stonepath/markhor/resonator-1"
            module: "quarre/MarkhorResonator.qml"

            description: "Manipulez les sliders afin d'altérer la résonance
 des percussions. Choisissez le son qui vous convient. Attention au temps !"

            length: 60
            countdown:  15

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_BODY
        {
            id:     interaction_body_1

            title:  "Corps de résonance (essais)"
            path:   "/stonepath/markhor/body-1"
            module: "quarre/MarkhorBody.qml"

            description: "Manipulez les sliders afin d'altérer le corps de résonance
 des percussions. Choisissez le son qui vous convient. Attention au temps !"

            length: 60
            countdown:  15

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_PADS
        {
            id:     interaction_pads_1

            title:  "Temps et Contretemps (essais)"
            path:   "/stonepath/markhor/pads-1"
            module: "quarre/MarkhorPads.qml"

            description: "Appuyez et maintenez l'un des pads (un seul à la fois)
 pour ajouter des compléments rythmiques."

            length: 175
            countdown:  15

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_GRANULAR_2
        {
            id:     interaction_granular_models_2

            title:  "Impulsions (tutti)"
            path:   "/stonepath/markhor/granular-2"
            module: "quarre/MarkhorGranular.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez,
 laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            length: 180
            countdown: 10

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS_2
        {
            id:     interaction_resonators_2

            title:  "Résonances (tutti)"
            path:   "/stonepath/markhor/resonator-2"
            module: "quarre/MarkhorResonator.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez,
 laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            length: 180
            countdown: 10

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_BODY_2
        {
            id:     interaction_body_2

            title:  "Corps de résonance (tutti)"
            path:   "/stonepath/markhor/body-2"
            module: "quarre/MarkhorBody.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez,
 laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            length: 180
            countdown: 10

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_PADS_2
        {
            id:     interaction_pads_2

            title:  "Temps et Contretemps (tutti)"
            path:   "/stonepath/markhor/pads-2"
            module: "quarre/MarkhorPads.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez,
 laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            length: 180
            countdown:  10

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
        id: markhor_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/audio/stonepath/markhor/rooms"

        WPN114.StereoSource //----------------------------------------- 1.DOOMSDAY (1-2)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.55

            exposePath: "/audio/stonepath/markhor/doomsday/source"

            WPN114.MultiSampler { id: doomsday;
                exposePath: "/audio/stonepath/markhor/doomsday"
                path: "audio/stonepath/markhor/doomsday" }
        }

        WPN114.StereoSource //----------------------------------------- 2.AMBIENT-LIGHT (3-4)
        {
            fixed: true
            xspread: 0.15
            diffuse: 0.3
            y: 0.85

            exposePath: "/audio/stonepath/markhor/ambient-light/source"

            WPN114.Sampler { id: ambient_light;
                exposePath: "/audio/stonepath/markhor/ambient-light"
                path: "audio/stonepath/markhor/ambient-light.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.PARORAL (5-6)
        {
            fixed: true
            xspread: 0.35
            diffuse: 0.65
            y: 0.7

            exposePath: "/audio/stonepath/markhor/paroral/source"

            WPN114.Sampler { id: paroral;
                exposePath: "/audio/stonepath/markhor/paroral"
                path: "audio/stonepath/markhor/paroral.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.SOUNDSCAPE (7-8)
        {
            fixed: true
            xspread: 0.25
            diffuse: 1.0
            y: 0.4

            exposePath: "/audio/stonepath/markhor/soundscape/source"

            WPN114.Sampler { id: soundscape;
                exposePath: "/audio/stonepath/markhor/soundscape"
                path: "audio/stonepath/markhor/soundscape.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.BELL_HIT (9-10)
        {
            fixed: true
            xspread: 0.05
            diffuse: 0.2
            y: 0.55

            exposePath: "/audio/stonepath/markhor/bell-hit/source"

            WPN114.Sampler { id: bell_hit;
                exposePath: "/audio/stonepath/markhor/bell-hit"
                path: "audio/stonepath/markhor/bell-hit.wav" }
        }
    }

}
