import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../.."

Item
{
    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //------------------------------------------------- SHAKE_LEAVES
        {
            id: shake_leaves_interaction
            title: "Feuillages, déclenchement"
            module: "basics/GestureShake.qml"
            length: 30
            countdown: 10

            description:
                "Exécutez le geste décrit ci-dessous
                 afin de déclencher des sons de feuillages"

            mappings: QuMapping
            {
                source: "gestures/shake/trigger"
                expression: function(v) { leaves.active = true; shake_leaves_interaction.end() }
            }
        }

        Interaction //------------------------------------------------- STATIC_BIRDS
        {
            id: static_birds_interaction
            title: "Chants d'oiseaux, déclenchements"
            module: "quarre/Birds.qml"
            length: 60
            countdown: 20

            description:
                "Touchez un oiseau lorsqu'il est arrêté pour déclencher son chant,
                 sa position sera retransmise dans l'espace sonore."

            mappings: QuMapping
            {
                source: "modules/birds/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //------------------------------------------------- FLYING_BIRDS
        {
            id: flying_birds_interaction
            title: "Oiseaux en vol, trajectoires"
            module: "quarre/Trajectories.qml"
            length: 45
            countdown: 20

            description:
                "Tracez une trajectoire sur la sphère ci-dessous avec votre doigt,
                 pendant quelques secondes, puis relachez pour déclencher"

            mappings: QuMapping
            {
                source: "modules/trajectories/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //------------------------------------------------- WOODRINGER
        {
            id: woodringer_interaction
            title: "Arbres, expirations"
            module: "basics/GesturePalm.qml"
            length: 20
            countdown: 10

            description:
                "Executez le geste décrit ci-dessous afin de déclencher un son grave"

            mappings: QuMapping
            {
                source: "gestures/palm/trigger"
                expression: function(v) {
                }
            }
        }

        Interaction //------------------------------------------------- WOODENBIRDS_SPAT
        {
            id: woodenbirds_spat_interaction
            title: "Oiseaux de bois, mise en espace"
            module: "basics/XRotation.qml"
            length: 60
            countdown: 20

            description:
                "Gardez votre appareil à plat, horizontalement,
                 puis orientez-le tout autour de vous pour identifier
                 et déplacer un son dans l'espace sonore."

            mappings: QuMapping
            {
                source: "gestures/palm/trigger"
                expression: function(v) {
                }
            }
        }
    }

    WPN114.Rooms
    {
        id: maaaet_rooms
        active: false
        parentStream: audio_stream
        configuration: rooms_config

        WPN114.RoomSource //----------------------------------------- 1.WIND (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/wind/spatialization"

            WPN114.Sampler { id: wind; stream: true;
                exposePath: "/audio/wood-path/maaaet/wind"
                path: "audio/wood-path/maaaet/wind.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.LIGHT_BACKGROUND (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/light-background/spatialization"

            WPN114.Sampler { id: light_background; stream: true;
                exposePath: "/audio/wood-path/maaaet/light-background"
                path: "audio/wood-path/maaaet/light-background.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.GRASSHOPPERS (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/grasshoppers/spatialization"

            WPN114.Sampler { id: grasshoppers; stream: true;
                exposePath: "/audio/wood-path/maaaet/grasshoppers"
                path: "audio/wood-path/maaaet/grasshoppers.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.GROUND_CREEEK (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/groundcreek/spatialization"

            WPN114.Sampler { id: groundcreek; stream: true;
                exposePath: "/audio/wood-path/maaaet/groundcreek"
                path: "audio/wood-path/maaaet/groundcreek.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.LEAVES (9-10)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/leaves/spatialization"

            WPN114.Sampler { id: leaves; stream: true;
                exposePath: "/audio/wood-path/maaaet/leaves"
                path: "audio/wood-path/maaaet/leaves.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.BLACKCAP (11-12)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/blackcap/spatialization"

            WPN114.Sampler { id: blackcap; stream: true;
                exposePath: "/audio/wood-path/maaaet/blackcap"
                path: "audio/wood-path/maaaet/blackcap.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 7.WOODPECKER (13-14)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/woodpecker/spatialization"

            WPN114.Sampler { id: woodpecker; stream: true;
                exposePath: "/audio/wood-path/maaaet/woodpecker"
                path: "audio/wood-path/maaaet/woodpecker.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 8.ORIOLE (15-16)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/oriole/spatialization"

            WPN114.Sampler { id: oriole; stream: true;
                exposePath: "/audio/wood-path/maaaet/oriole"
                path: "audio/wood-path/maaaet/oriole.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 9.NIGHTINGALE (17-18)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/nightingale/spatialization"

            WPN114.Sampler { id: nightingale; stream: true;
                exposePath: "/audio/wood-path/maaaet/nightingale"
                path: "audio/wood-path/maaaet/nightingale.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 10.FLYING_BIRDS (19-20)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/flying-birds/spatialization"

            WPN114.Sampler { id: flying_birds; stream: true;
                exposePath: "/audio/wood-path/maaaet/flying-birds"
                path: "audio/wood-path/maaaet/flying-birds.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 11.WOODRINGER_LOW (21-22)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/woodringer-low/spatialization"

            WPN114.Sampler { id: woodringer_low; stream: true;
                exposePath: "/audio/wood-path/maaaet/woodringer-low"
                path: "audio/wood-path/maaaet/woodringer-low.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 12.WOODRINGER_LOW_RISE (23-24)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/woodringer-low-rise/spatialization"

            WPN114.Sampler { id: woodringer_low_rise; stream: true;
                exposePath: "/audio/wood-path/maaaet/woodringer-low-rise"
                path: "audio/wood-path/maaaet/woodringer-low-rise.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 13.WOODRINGER_HI (25-26)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/woodringer-high/spatialization"

            WPN114.Sampler { id: woodringer_high; stream: true;
                exposePath: "/audio/wood-path/maaaet/woodringer-high"
                path: "audio/wood-path/maaaet/woodringer-high.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 14.WOODEN_BIRDS (27-28)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/woodenbirds/spatialization"

            WPN114.Sampler { id: woodenbirds; stream: true;
                exposePath: "/audio/wood-path/maaaet/woodenbirds"
                path: "audio/wood-path/maaaet/woodenbirds.wav" }
        }


        WPN114.RoomSource //----------------------------------------- 15.BIRDS_BACKGROUND (29-30)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/maaaet/birds-background/spatialization"

            WPN114.Sampler { id: birds_background; stream: true;
                exposePath: "/audio/wood-path/maaaet/birds-background"
                path: "audio/wood-path/maaaet/birds-background.wav" }
        }
    }

}
