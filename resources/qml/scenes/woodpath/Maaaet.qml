import QtQuick 2.0
import WPN114 1.0 as WPN114

import "../../engine"
import ".."

Scene
{
    id: root

    scenario: WPN114.TimeNode
    {
        source: audiostream
        parentNode: parent.scenario
        duration: WPN114.TimeNode.Infinite
        onStart:
        {
            wind.play();
            rooms.dBlevel = -3
        }

        //=============================================================== AMBIENT

        WPN114.TimeNode { date: sec( 3 ); onStart: { grove.play(); windleaves.play(); spring.play() } }
        WPN114.TimeNode { date: min( 1 ); onStart: woodworks.play() }

        WPN114.Loop //=================================================== SHAKE_LEAVES
        {
            date: sec( 10 )
            pattern.duration: sec( 50 )
            times: 4

            InteractionExecutor
            {
                id:         shake_leaves_interaction_ex
                target:     shake_leaves_interaction
                countdown:  sec( 10 )
                length:     sec( 30 )
            }

            onEnd: shake_leaves_interaction.end();
        }

        InteractionExecutor //========================================== STATIC_BIRDS
        {
            target:     static_birds_interaction
            date:       sec( 15 )
            countdown:  sec( 20 )
            length:     sec( 60 )
        }

        InteractionExecutor //========================================= FLYING_BIRDS
        {
            id:         flying_birds_ex
            target:     flying_birds_interaction

            date:       min( 1 )
            length:     sec( 45 )
            countdown:  sec( 20 )
        }

        InteractionExecutor //========================================== STATIC_BIRDS_2
        {
            id:         static_birds_2_ex
            target:     static_birds_interaction

            after:      flying_birds_ex
            date:       sec( 15 )
            countdown:  sec( 20 )
            length:     sec( 60 )
        }

        InteractionExecutor //========================================= FLYING_BIRDS_2
        {
            target:     flying_birds_interaction
            after:      flying_birds_ex
            date:       sec( 30 )
            length:     sec( 45 )
            countdown:  sec( 20 )

            WPN114.Automation
            {
                target: woodworks_2
                property: "level"
                from: 0; to: 1;
                duration: sec( 45 )

                onStart: woodworks_2.play()
            }
        }

        InteractionExecutor //========================================= WOODENBIRDS
        {
            id:         woodenbirds_ex
            target:     woodenbirds_spat_interaction
            after:      static_birds_2_ex
            date:       sec( 5 )
            countdown:  sec( 20 )
            length:     sec( 60 )

            onStart:    woodenbirds.play();
            onEnd:      woodenbirds.stop();
        }

        WPN114.Automation //========================================= FADE_OUT
        {
            after: woodenbirds_ex
            target: rooms
            property: "level"
            from: 1; to: 0;
            duration: sec( 90 )

            // NEXT
            WPN114.TimeNode { date: sec( 22 ); onStart: next() }
            onEnd: scenario.end();
        }
    }

    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //------------------------------------------------- SHAKE_LEAVES
        {
            id:      shake_leaves_interaction
            title:   "Feuillages, déclenchement"
            module:  "basics/GestureShake.qml"
            description: "Executez le geste décrit ci-dessous"

            mappings: QuMapping
            {
                source: "/gestures/shake/trigger"
                expression: function(v) {
                    leaves.playRandom();
                    shake_leaves_interaction_ex.end();
                }
            }
        }

        Interaction //------------------------------------------------- STATIC_BIRDS
        {
            id: static_birds_interaction
            title: "Chants d'oiseaux, déclenchements"
            module: "quarre/Birds.qml"
            description: "Touchez un oiseau lorsqu'il est arrêté pour déclencher son chant, sa position sera retransmise dans l'espace sonore."

            property var sources:  [ blackcap_source, woodpecker_source,
                                     oriole_source, nightingale_source ];

            property var samplers: [ blackcap, woodpecker, oriole, nightingale ]

            mappings: QuMapping
            {
                source: "/modules/birds/trigger"
                expression: function(v) {
                    static_birds_interaction.sources[v[0]].position = Qt.vector3d(v[1], 1-v[2], 0.5);
                    static_birds_interaction.samplers[v[0]].playRandom();
                }
            }
        }

        Interaction //------------------------------------------------- FLYING_BIRDS
        {
            id: flying_birds_interaction
            title: "Oiseaux en vol, trajectoires"
            path:   "/woodpath/maaaet/interactions/flying-birds"
            module: "quarre/Trajectories.qml"

            description:
                "Tracez une trajectoire sur la sphère ci-dessous avec votre doigt, pendant quelques secondes, puis relachez pour déclencher"

            mappings: [
                QuMapping {
                    source: "/modules/trajectories/trigger"
                    expression: function(v) { flying_birds.playRandom() }},

                QuMapping {
                    source: "/modules/trajectories/position2D"
                    expression: function(v) {
                        flying_birds_source.position = Qt.vector3d(v[0], 1-v[1], 0.5);
                    }
                }
            ]
        }

        Interaction //------------------------------------------------- WOODENBIRDS_SPAT
        {
            id:     woodenbirds_spat_interaction
            title:  "Oiseaux de bois, mise en espace"
            path:   "/woodpath/maaaet/interactions/woodenbirds"
            module: "basics/XYZRotation3D.qml"

            description: "Gardez votre appareil à plat, horizontalement, puis orientez-le tout autour de vous pour identifier et déplacer un son dans l'espace sonore."

            mappings: QuMapping
            {
                source: "/modules/rotation3D/position"
                expression: function(v) {
                    woodenbirds_source.position = Qt.vector3d(v[0], v[1], v[2])
                }
            }
        }
    }

    //===================================================================================== AUDIO

    WPN114.StereoSource //========================================= SPRING
    {
        parentStream: rooms
        fixed: true
        yspread: 0.25
        z: 0.0

        exposePath: fmt("audio/spring/source")

        WPN114.StreamSampler { id: spring; loop: true; xfade: 3000
            exposePath: fmt("audio/spring");
            path: "audio/introduction/spring.wav"
            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.StereoSource //========================================= WINDLEAVES
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.1
        xspread: 0.25
        z: 0.8

        exposePath: fmt("audio/windleaves/source")

        WPN114.StreamSampler { id: windleaves; loop: true; xfade: 3000
            exposePath: fmt("audio/windleaves")
            path: "audio/woodpath/maaaet/windleaves.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.StereoSource //========================================= GROVE
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.5
        yspread: 0.25
        z: 0.2

        exposePath: fmt("audio/grove/source")

        WPN114.StreamSampler { id: grove; loop: true; xfade: 3000
            exposePath: fmt("audio/grove")
            path: "audio/woodpath/maaaet/grove.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -3 }
        }
    }

    WPN114.StereoSource //========================================= WIND
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.5
        yspread: 0.25
        z: 0.7

        exposePath: fmt("audio/wind/source")

        WPN114.StreamSampler { id: wind; loop: true; xfade: 3000
            exposePath: fmt("audio/wind")
            path: "audio/woodpath/maaaet/wind.wav"
        }
    }

    WPN114.StereoSource //========================================= WOODWORKS
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.1
        xspread: 0.25
        z: 0.5

        exposePath: fmt("audio/woodworks/source")

        WPN114.StreamSampler { id: woodworks
            exposePath: fmt("audio/woodworks")
            path: "audio/woodpath/maaaet/woodworks.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -3 }
        }
    }

    WPN114.StereoSource //========================================= WOODWORKS_2
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.2
        yspread: 0.25
        z: 0.25

        exposePath: fmt("audio/woodworks2/source")

        WPN114.StreamSampler { id: woodworks_2
            exposePath: fmt("audio/woodworks2")
            path: "audio/woodpath/maaaet/woodworks2.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -3 }
        }
    }

    WPN114.StereoSource //========================================= LEAVES
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.2
        xspread: 0.25
        y: 0.75
        z: 0.35

        exposePath: fmt("audio/leaves/source")

        WPN114.MultiSampler { id: leaves;
            exposePath: fmt("audio/leaves")
            path: "audio/woodpath/maaaet/leaves"

            WPN114.Fork { target: effects.reverb; dBlevel: -6 }
        }
    }

    WPN114.MonoSource //========================================= BLACKCAP
    {
        id: blackcap_source
        parentStream: rooms
        exposePath: fmt("audio/blackcap/source")

        position: Qt.vector3d(0.5, 0.5, 0.99)

        WPN114.MultiSampler { id: blackcap;
            exposePath: fmt("audio/blackcap")
            path: "audio/woodpath/maaaet/blackcap"

            WPN114.Fork { target: effects.reverb; dBlevel: -12 }
        }
    }

    WPN114.MonoSource //========================================= WOODPECKER
    {
        id: woodpecker_source
        parentStream: rooms
        exposePath: fmt("audio/woodpecker/source")

        WPN114.MultiSampler { id: woodpecker;
            exposePath: fmt("audio/woodpecker")
            path: "audio/woodpath/maaaet/woodpecker"

            WPN114.Fork { target: effects.reverb; dBlevel: -12 }
        }
    }

    WPN114.MonoSource //========================================= ORIOLE
    {
        id: oriole_source
        parentStream: rooms
        exposePath: fmt("audio/oriole/source")

        WPN114.MultiSampler { id: oriole;
            exposePath: fmt("audio/oriole")
            path: "audio/woodpath/maaaet/oriole"
            WPN114.Fork { target: effects.reverb; dBlevel: -12 }
        }
    }

    WPN114.MonoSource //========================================= NIGHTINGALE
    {
        id: nightingale_source
        parentStream: rooms
        exposePath: fmt("audio/nightingale/source")

        WPN114.MultiSampler { id: nightingale;
            exposePath: fmt("audio/nightingale")
            path: "audio/woodpath/maaaet/nightingale"

            WPN114.Fork { target: effects.reverb; dBlevel: -12 }
        }
    }

    WPN114.MonoSource //========================================= FLYING_BIRDS
    {
        id: flying_birds_source
        parentStream: rooms
        exposePath: fmt("audio/flying-birds/source")

        WPN114.MultiSampler { id: flying_birds;
            exposePath: fmt("audio/flying-birds")
            path: "audio/woodpath/maaaet/flying-birds"
            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.MonoSource //========================================= WOODEN_BIRDS
    {
        id: woodenbirds_source
        parentStream: rooms
        exposePath: fmt("audio/woodenbirds/source")

        WPN114.Sampler { id: woodenbirds; dBlevel: 6
            exposePath: fmt("audio/woodenbirds")
            path: "audio/woodpath/maaaet/woodenbirds.wav"

            WPN114.Fork { target: effects.reverb; dBlevel: -6 }
        }
    }
}
