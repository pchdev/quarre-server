import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../.."

Item
{
    WPN114.TimeNode
    {

    }


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

            description: ""

            mappings: QuMapping
            {
                source: "/modules/gestures/shaking"
                expression: function(v) {
                    if ( v ) leaves.play();
                    else leaves.stop();
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
                    var target_source;
                    if ( v[0] === 0 )
                    {
                        target_source = blackcap_source;
                        blackcap.playRandom()
                    }
                    else if ( v[0] === 1 )
                    {
                        target_source = woodpecker_source;
                        woodpecker.playRandom();
                    }
                    else if ( v[0] === 2 )
                    {
                        target_source = oriole_source;
                        oriole.playRandom();
                    }
                    else if ( v[0] === 3 )
                    {
                        target_source = nightingale_source;
                        nightingale.playRandom();
                    }
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

            mappings: [
                QuMapping {
                    source: "/modules/trajectories/trigger"
                    expression: function(v) { flying_birds.playRandom() }},

                QuMapping {
                    source: "/modules/trajectories/position2D"
                    expression: function(v) {
                        flying_birds_source.position = Qt.vector3d(v[0], v[1], 0.5);
                    }
                }
            ]
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
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    woodenbirds_source.position = Qt.vector3d(v[0], v[1], 0.5);
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

        WPN114.StereoSource //-----------------------------------------
        {
        }

        WPN114.StereoSource //----------------------------------------- 5.LEAVES (9-10)
        {
            fixed: true
            diffuse: 0.4
            xspread: 0.25
            y: 0.75

            exposePath: "/audio/woodpath/maaaet/leaves/source"

            WPN114.Sampler { id: leaves; attack: 2000; release: 2000;
                exposePath: "/audio/woodpath/maaaet/leaves"
                path: "audio/woodpath/maaaet/leaves.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 6.BLACKCAP (11-12)
        {
            id: blackcap_source
            exposePath: "/audio/woodpath/maaaet/blackcap/source"

            WPN114.MultiSampler { id: blackcap;
                exposePath: "/audio/woodpath/maaaet/blackcap"
                path: "audio/woodpath/maaaet/blackcap" }
        }

        WPN114.MonoSource //----------------------------------------- 7.WOODPECKER (13-14)
        {
            id: woodpecker_source
            exposePath: "/audio/woodpath/maaaet/woodpecker/source"

            WPN114.MultiSampler { id: woodpecker;
                exposePath: "/audio/woodpath/maaaet/woodpecker"
                path: "audio/woodpath/maaaet/woodpecker" }
        }


        WPN114.MonoSource //----------------------------------------- 8.ORIOLE (15-16)
        {
            id: oriole_source
            exposePath: "/audio/woodpath/maaaet/oriole/source"

            WPN114.Sampler { id: oriole;
                exposePath: "/audio/woodpath/maaaet/oriole"
                path: "audio/woodpath/maaaet/oriole" }
        }

        WPN114.MonoSource //----------------------------------------- 9.NIGHTINGALE (17-18)
        {
            id: nightingale_source
            exposePath: "/audio/woodpath/maaaet/nightingale/source"

            WPN114.MultiSampler { id: nightingale;
                exposePath: "/audio/woodpath/maaaet/nightingale"
                path: "audio/woodpath/maaaet/nightingale" }
        }


        WPN114.MonoSource //----------------------------------------- 10.FLYING_BIRDS (19-20)
        {
            id: flying_birds_source
            exposePath: "/audio/woodpath/maaaet/flying-birds/source"

            WPN114.MultiSampler { id: flying_birds;
                exposePath: "/audio/woodpath/maaaet/flying-birds"
                path: "audio/woodpath/maaaet/flying-birds" }
        }

        WPN114.MonoSource //----------------------------------------- 14.WOODEN_BIRDS (27-28)
        {
            id: woodenbirds_source
            exposePath: "/audio/woodpath/maaaet/woodenbirds/source"

            WPN114.Sampler { id: woodenbirds;
                exposePath: "/audio/woodpath/maaaet/woodenbirds"
                path: "audio/woodpath/maaaet/woodenbirds.wav" }
        }
    }
}
