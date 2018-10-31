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
        id:           scenario
        source:       audio_stream
        exposePath:   "/woodpath/maaaet/scenario"

        duration: -1

        onStart:
        {
            maaaet_rooms.active = true
            instruments.rooms.active = false;
            client_manager.notifyScene("maaaet");
        }

        // we start with some forest ambiance ---------------------------
        WPN114.TimeNode { onStart: { grove.play(); windleaves.play(); spring.play() } }
        WPN114.TimeNode { date: min(1); onStart: woodworks.play() }

        WPN114.Loop //------------------------------------------- SHAKE_LEAVES
        {

            date: sec( 10 )
            pattern.duration: sec( 50 )
            times: 4

            InteractionExecutor
            {
                target:     shake_leaves_interaction
                countdown:  sec( 10 )
                length:     sec( 30 )
            }
        }

        InteractionExecutor //----------------------------------- STATIC_BIRDS
        {
            target:     static_birds_interaction
            date:       sec( 15 )
            countdown:  sec( 20 )
            length:     sec( 60 )

            // duration: 80s
        }

        InteractionExecutor //----------------------------------- FLYING_BIRDS
        {
            id:         flb
            target:     flying_birds_interaction

            date:       min( 1 )
            length:     sec( 45 )
            countdown:  sec( 20 )
        }

        InteractionExecutor //----------------------------------- STATIC_BIRDS_2
        {
            id:         sbi2
            target:     static_birds_interaction

            after:      flb
            date:       sec( 15 )
            countdown:  sec( 20 )
            length:     sec( 60 )
        }

        InteractionExecutor //----------------------------------- FLYING_BIRDS_2
        {
            target:     flying_birds_interaction
            onStart:    woodworks_2.play()

            after:      flb
            date:       sec( 30 )
            length:     sec( 45 )
            countdown:  sec( 20 )
        }

        InteractionExecutor //----------------------------------- WOODENBIRDS
        {
            id:         woodenbirds_ex
            target:     woodenbirds_spat_interaction

            after:      sbi2
            date:       sec( 5 )
            countdown:  sec( 20 )
            length:     sec( 60 )

        }

        WPN114.Automation //------------------------------------- FADE_OUT
        {
            after: woodenbirds_ex
            target: maaaet_rooms
            property: "level"
            from: 1; to: 0;
            duration: sec(45)

            WPN114.TimeNode { date: sec(22); onStart: root.next() }
            onEnd: maaaet_rooms.active = false;
        }
    }

    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //------------------------------------------------- SHAKE_LEAVES
        {
            id: shake_leaves_interaction
            title: "Feuillages, déclenchement"
            module: "basics/GestureShakeThresh.qml"

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

                    target_source.position = Qt.vector3d(v[1], v[2], 0.5);
                }
            }
        }

        Interaction //------------------------------------------------- FLYING_BIRDS
        {
            id: flying_birds_interaction
            title: "Oiseaux en vol, trajectoires"
            module: "quarre/Trajectories.qml"

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

        WPN114.StereoSource //----------------------------------------- SPRING
        {
            fixed: true
            diffuse: 0.5
            yspread: 0.25

            exposePath: "/woodpath/maaaet/audio/spring/source"

            WPN114.Sampler { id: spring; loop: true; xfade: 3000
                exposePath: "/woodpath/maaaet/audio/spring"
                path: "audio/woodpath/maaaet/spring.wav"
            }
        }

        WPN114.StereoSource //----------------------------------------- WINDLEAVES
        {
            fixed: true
            diffuse: 0.5
            yspread: 0.25

            exposePath: "/woodpath/maaaet/audio/windleaves/source"

            WPN114.Sampler { id: windleaves; loop: true; xfade: 3000
                exposePath: "/woodpath/maaaet/windleaves"
                path: "audio/woodpath/maaaet/windleaves.wav"
            }
        }

        WPN114.StereoSource //----------------------------------------- GROVE
        {
            fixed: true
            diffuse: 0.5
            yspread: 0.25

            exposePath: "/woodpath/maaaet/audio/grove/source"

            WPN114.Sampler { id: grove; loop: true; xfade: 3000
                exposePath: "/woodpath/maaaet/audio/grove"
                path: "audio/woodpath/maaaet/grove.wav"
            }
        }

        WPN114.StereoSource //----------------------------------------- GROVE
        {
            fixed: true
            diffuse: 0.5
            yspread: 0.25

            exposePath: "/woodpath/maaaet/audio/woodworks/source"

            WPN114.Sampler { id: woodworks
                exposePath: "/woodpath/maaaet/audio/woodworks"
                path: "audio/woodpath/maaaet/woodworks.wav"
            }
        }

        WPN114.StereoSource //----------------------------------------- WOODWORKS_2
        {
            fixed: true
            diffuse: 0.5
            yspread: 0.25

            exposePath: "/woodpath/maaaet/audio/woodworks2/source"

            WPN114.Sampler { id: woodworks_2
                exposePath: "/woodpath/maaaet/audio/woodworks2"
                path: "audio/woodpath/maaaet/woodworks2.wav"
            }
        }

        WPN114.StereoSource //----------------------------------------- 5.LEAVES (9-10)
        {
            fixed: true
            diffuse: 0.4
            xspread: 0.25
            y: 0.75

            exposePath: "/woodpath/maaaet/audio/leaves/source"

            WPN114.Sampler { id: leaves; attack: 2000; release: 2000;
                exposePath: "/woodpath/maaaet/audio/leaves"
                path: "audio/woodpath/maaaet/leaves.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 6.BLACKCAP (11-12)
        {
            id: blackcap_source
            exposePath: "/woodpath/maaaet/audio/blackcap/source"

            WPN114.MultiSampler { id: blackcap;
                exposePath: "/woodpath/maaaet/audio/blackcap"
                path: "audio/woodpath/maaaet/blackcap" }
        }

        WPN114.MonoSource //----------------------------------------- 7.WOODPECKER (13-14)
        {
            id: woodpecker_source
            exposePath: "/woodpath/maaaet/audio/woodpecker/source"

            WPN114.MultiSampler { id: woodpecker;
                exposePath: "/woodpath/maaaet/audio/woodpecker"
                path: "audio/woodpath/maaaet/woodpecker" }
        }


        WPN114.MonoSource //----------------------------------------- 8.ORIOLE (15-16)
        {
            id: oriole_source
            exposePath: "/woodpath/maaaet/audio/oriole/source"

            WPN114.Sampler { id: oriole;
                exposePath: "/woodpath/maaaet/audio/oriole"
                path: "audio/woodpath/maaaet/oriole" }
        }

        WPN114.MonoSource //----------------------------------------- 9.NIGHTINGALE (17-18)
        {
            id: nightingale_source
            exposePath: "/woodpath/maaaet/audio/nightingale/source"

            WPN114.MultiSampler { id: nightingale;
                exposePath: "/woodpath/maaaet/audio/nightingale"
                path: "audio/woodpath/maaaet/nightingale" }
        }


        WPN114.MonoSource //----------------------------------------- 10.FLYING_BIRDS (19-20)
        {
            id: flying_birds_source
            exposePath: "/woodpath/maaaet/audio/flying-birds/source"

            WPN114.MultiSampler { id: flying_birds;
                exposePath: "/woodpath/maaaet/audio/flying-birds"
                path: "audio/woodpath/maaaet/flying-birds" }
        }

        WPN114.MonoSource //----------------------------------------- 14.WOODEN_BIRDS (27-28)
        {
            id: woodenbirds_source
            exposePath: "/woodpath/maaaet/audio/woodenbirds/source"

            WPN114.Sampler { id: woodenbirds;
                exposePath: "/woodpath/maaaet/audio/woodenbirds"
                path: "audio/woodpath/maaaet/woodenbirds.wav" }
        }
    }
}
