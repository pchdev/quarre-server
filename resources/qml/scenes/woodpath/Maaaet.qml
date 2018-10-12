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
                expression: function(v) {
                    leaves.active = true; shake_leaves_interaction.end()
                }
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
        setup: rooms_setup

        WPN114.StereoSource //----------------------------------------- 1.WIND (1-2)
        {
            yspread: 0.35
            diffuse: 0.8
            fixed: true

            exposePath: "/audio/woodpath/maaaet/wind/source"

            WPN114.StreamSampler { id: wind;
                exposePath: "/audio/woodpath/maaaet/wind"
                path: "audio/woodpath/maaaet/wind.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.LIGHT_BACKGROUND (3-4)
        {            
            xspread: 0.25
            yspread: 0.25
            diffuse: 0.55
            fixed: true

            exposePath: "/audio/woodpath/maaaet/light-background/source"

            WPN114.Sampler { id: light_background;
                exposePath: "/audio/woodpath/maaaet/light-background"
                path: "audio/woodpath/maaaet/light-background.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 3.GRASSHOPPERS (5-6)
        {
            fixed: true
            y: 0.82

            exposePath: "/audio/woodpath/maaaet/grasshoppers/source"

            WPN114.Sampler { id: grasshoppers;
                exposePath: "/audio/woodpath/maaaet/grasshoppers"
                path: "audio/woodpath/maaaet/grasshoppers.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.GROUND_CREEEK (7-8)
        {
            fixed: true
            diffuse: 0.5
            xspread: 0.25
            y: 0.75

            exposePath: "/audio/woodpath/maaaet/groundcreek/source"

            WPN114.Sampler { id: groundcreek;
                exposePath: "/audio/woodpath/maaaet/groundcreek"
                path: "audio/woodpath/maaaet/groundcreek.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.LEAVES (9-10)
        {
            fixed: true
            diffuse: 0.4
            xspread: 0.25
            y: 0.75

            exposePath: "/audio/woodpath/maaaet/leaves/source"

            WPN114.Sampler { id: leaves;
                exposePath: "/audio/woodpath/maaaet/leaves"
                path: "audio/woodpath/maaaet/leaves.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 6.BLACKCAP (11-12)
        {
            exposePath: "/audio/woodpath/maaaet/blackcap/source"

            WPN114.Sampler { id: blackcap;
                exposePath: "/audio/woodpath/maaaet/blackcap"
                path: "audio/woodpath/maaaet/blackcap" }
        }

        WPN114.MonoSource //----------------------------------------- 7.WOODPECKER (13-14)
        {
            exposePath: "/audio/woodpath/maaaet/woodpecker/source"

            WPN114.Sampler { id: woodpecker;
                exposePath: "/audio/woodpath/maaaet/woodpecker"
                path: "audio/woodpath/maaaet/woodpecker" }
        }


        WPN114.MonoSource //----------------------------------------- 8.ORIOLE (15-16)
        {
            exposePath: "/audio/woodpath/maaaet/oriole/source"

            WPN114.Sampler { id: oriole;
                exposePath: "/audio/woodpath/maaaet/oriole"
                path: "audio/woodpath/maaaet/oriole" }
        }

        WPN114.MonoSource //----------------------------------------- 9.NIGHTINGALE (17-18)
        {
            exposePath: "/audio/woodpath/maaaet/nightingale/source"

            WPN114.Sampler { id: nightingale;
                exposePath: "/audio/woodpath/maaaet/nightingale"
                path: "audio/woodpath/maaaet/nightingale" }
        }


        WPN114.MonoSource //----------------------------------------- 10.FLYING_BIRDS (19-20)
        {
            exposePath: "/audio/woodpath/maaaet/flying-birds/source"

            WPN114.Sampler { id: flying_birds;
                exposePath: "/audio/woodpath/maaaet/flying-birds"
                path: "audio/woodpath/maaaet/flying-birds" }
        }


        WPN114.StereoSource //----------------------------------------- 11.WOODRINGER_LOW (21-22)
        {
            fixed: true
            yspread: 0.3
            diffuse: 0.6

            exposePath: "/audio/woodpath/maaaet/woodringer-low/source"

            WPN114.Sampler { id: woodringer_low;
                exposePath: "/audio/woodpath/maaaet/woodringer-low"
                path: "audio/woodpath/maaaet/woodringer-low.wav" }
        }


        WPN114.StereoSource //----------------------------------------- 12.WOODRINGER_LOW_RISE (23-24)
        {
            fixed: true
            xspread: 0.3
            diffuse: 0.25
            y: 0.85

            exposePath: "/audio/woodpath/maaaet/woodringer-low-rise/source"

            WPN114.Sampler { id: woodringer_low_rise;
                exposePath: "/audio/woodpath/maaaet/woodringer-low-rise"
                path: "audio/woodpath/maaaet/woodringer-low-rise.wav" }
        }


        WPN114.StereoSource //----------------------------------------- 13.WOODRINGER_HI (25-26)
        {
            fixed: true
            xspread: 0.3
            y: 0.8

            exposePath: "/audio/woodpath/maaaet/woodringer-high/source"

            WPN114.Sampler { id: woodringer_high;
                exposePath: "/audio/woodpath/maaaet/woodringer-high"
                path: "audio/woodpath/maaaet/woodringer-high.wav" }
        }


        WPN114.MonoSource //----------------------------------------- 14.WOODEN_BIRDS (27-28)
        {
            exposePath: "/audio/woodpath/maaaet/woodenbirds/source"

            WPN114.Sampler { id: woodenbirds;
                exposePath: "/audio/woodpath/maaaet/woodenbirds"
                path: "audio/woodpath/maaaet/woodenbirds.wav" }
        }


        WPN114.StereoSource //----------------------------------------- 15.BIRDS_BACKGROUND (29-30)
        {
            fixed: true
            yspread: 0.25
            diffuse: 0.8

            exposePath: "/audio/woodpath/maaaet/birds-background/spatialization"

            WPN114.Sampler { id: birds_background;
                exposePath: "/audio/woodpath/maaaet/birds-background"
                path: "audio/woodpath/maaaet/birds-background.wav" }
        }
    }

}
