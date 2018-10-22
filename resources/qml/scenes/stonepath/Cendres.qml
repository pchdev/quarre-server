import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    property alias rooms: cendres_rooms
    property alias interaction_thunder:     interaction_thunder
    property alias interaction_boiling:     interaction_boiling
    property alias interaction_marmottes:   interaction_marmottes
    property alias interaction_dragon:      interaction_dragon
    property alias interaction_groundwalk:  interaction_groundwalk
    property alias interaction_birds:       interaction_flying_birds

    WPN114.Node
    {
        path: "/stonepath/cendres/active"
        type: WPN114.Type.Bool

        onValueReceived:
        {
            if ( newValue )
            {
                instruments.kaivo_1.active = false;
                instruments.kaivo_2.active = false;
                instruments.absynth.active = false;
                effects.amplitube.active = false;
            }

            cendres_rooms.active = newValue;
        }
    }

    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- ORAGE_HAMMER
        {
            id:     interaction_thunder

            title:  "Orage, déclenchement"
            path:   "/stonepath/cendres/interactions/orage"
            module: "basics/GestureHammer.qml"

            description: "Executez le geste décrit ci-dessous pour déclencher un son d'orage."

            countdown:  10
            length: 20

            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                    interaction_thunder.end();
                    thunder.playRandom();
                }
            }
        }

        Interaction //--------------------------------------------- BOILING_PALM
        {
            id:     interaction_boiling

            title:  "Source volcanique, déclenchement"
            path:   "/stonepath/cendres/interactions/boiling"
            module: "basics/GesturePalm.qml"

            description: "Executez le geste décrit ci-dessous pour déclencher un son."

            countdown:  10
            length: 20

            mappings: QuMapping
            {
                source: "/gestures/cover/trigger"
                expression: function(v) {
                    boiling.play();
                    interaction_boiling.end()
                }
            }
        }

        Interaction //--------------------------------------------- MARMOTTES
        {
            id:     interaction_marmottes

            title:  "Paysages, marmottes"
            path:   "/stonepath/cendres/interactions/marmottes"
            module: "basics/XYTouch.qml"

            description: "Touchez du doigt un endroit de la sphère afin de déclencher
 et de mettre en espace un cri de marmotte."

            countdown: 15
            length: 45

            mappings: QuMapping
            {
                source: "/modules/xytouch/position2D"
                expression: function(v) {
                    marmots.playRandom();
                    marmots_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }

        Interaction //--------------------------------------------- DRAGON_SPAT
        {
            id:     interaction_dragon

            title:  "Dragon, mise en espace"
            path:   "/stonepath/cendres/interactions/dragon"
            module: "basics/ZRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son dans l'espace."

            countdown:  20
            length: 80

            onInteractionNotify: dragon.play();
            onInteractionEnd:    dragon.stop();

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    dragon_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }

        Interaction //--------------------------------------------- GROUNDWALK
        {
            id:     interaction_groundwalk

            title:  "Bruits de pas, mise en espace"
            path:   "/stonepath/cendres/interactions/groundwalk"
            module: "basics/ZRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son dans l'espace."

            countdown: 20
            length: 60

            onInteractionNotify: groundwalk.play();
            onInteractionEnd:    groundwalk.stop();

            mappings: QuMapping
            {
                source: "/modules/zrotation/position2D"
                expression: function(v) {
                    groundwalk_source.position = Qt.vector3d(v[0], v[1], 0.5);
                }
            }
        }

        Interaction //--------------------------------------------- BIRDS_TRAJECTORIES
        {
            id: interaction_flying_birds

            title:  "Oiseaux en vol, trajectoires"
            path:   "/stonepath/cendres/interactions/birds"
            module: "quarre/Trajectories.qml"

            description: "Tracez une trajectoire sur la sphère ci-dessous avec votre doigt,
 pendant quelques secondes, puis relachez pour déclencher"

            countdown: 15
            length: 60

            mappings: [
                QuMapping {
                    source: "/modules/trajectories/trigger"
                    expression: function(v) { birds.playRandom() }},

                QuMapping {
                    source: "/modules/trajectories/position2D"
                    expression: function(v) {
                        birds_source.position = Qt.vector3d(v[0], v[1], 0.5);
                    }
                }
            ]
        }
    }

    WPN114.Rooms //-------------------------------------------------------------------- AUDIO
    {
        id: cendres_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/stonepath/cendres/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.ASHES (1-2)
        {
            exposePath: "/stonepath/cendres/audio/ashes/source"

            fixed:   true
            xspread: 0.25
            yspread: 0.2
            diffuse: 0.47

            WPN114.StreamSampler { id: ashes;
                exposePath: "/stonepath/cendres/audio/ashes"
                path: "audio/stonepath/cendres/ashes.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 2.REBIRDS_1 (3-4)
        {
            exposePath: "/stonepath/cendres/audio/redbirds-1/source"

            fixed:      true
            xspread:    0.3
            y:          0.9

            WPN114.StreamSampler { id: redbirds_1;
                exposePath: "/stonepath/cendres/audio/redbirds-1"
                path: "audio/stonepath/cendres/redbirds-1.wav"
            }
        }

        WPN114.StereoSource //----------------------------------------- 3.REBIRDS_2 (5-6)
        {
            exposePath: "/stonepath/cendres/audio/redbirds-2/source"

            fixed:      true
            xspread:    0.3
            y:          0.1

            WPN114.StreamSampler { id: redbirds_2;
                exposePath: "/stonepath/cendres/audio/redbirds-2"
                path: "audio/stonepath/cendres/redbirds-2.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.LIGHT-BACKGROUND (7-8)
        {
            exposePath: "/stonepath/cendres/audio/light-background/source"

            xspread: 0.25
            yspread: 0.25
            diffuse: 0.5
            fixed: true

            WPN114.Sampler { id: light_background;
                exposePath: "/stonepath/cendres/audio/light-background"
                path: "audio/stonepath/cendres/light-background.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.BURN (9-10)
        {
            exposePath: "/stonepath/cendres/audio/burn/source"

            xspread: 0.3
            diffuse: 0.7
            fixed: true
            y: 0.1

            WPN114.StreamSampler { id: burn;
                exposePath: "/stonepath/cendres/audio/burn"
                path: "audio/stonepath/cendres/burn.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -9 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 6.WAVES (11-12)
        {
            exposePath: "/stonepath/cendres/audio/waves/source"

            xspread: 0.42
            diffuse: 0.35
            fixed: true

            WPN114.Sampler { id: waves;
                exposePath: "/stonepath/cendres/audio/waves"
                path: "audio/stonepath/cendres/waves.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 7.THUNDER (13-14)
        {
            exposePath: "/stonepath/cendres/audio/thunder/source"

            xspread: 0.25
            diffuse: 0.6
            fixed: true
            y: 0.75

            WPN114.MultiSampler { id: thunder;
                exposePath: "/stonepath/cendres/audio/thunder"
                path: "audio/stonepath/cendres/thunder"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 8.MARMOTS (15-16)
        {
            id:         marmots_source;
            exposePath: "/stonepath/cendres/audio/marmots/source"

            WPN114.MultiSampler { id: marmots;
                exposePath: "/stonepath/cendres/audio/marmots"
                path: "audio/stonepath/cendres/marmots" }
        }

        WPN114.StereoSource //----------------------------------------- 9.BOILING (17-18)
        {
            exposePath: "/stonepath/cendres/audio/boiling/source"

            xspread: 0.5
            fixed: true
            y: 0.55

            WPN114.Sampler { id: boiling;
                exposePath: "/stonepath/cendres/audio/boiling"
                path: "audio/stonepath/cendres/boiling.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 10.QUARRE (19-20)
        {
            exposePath: "/stonepath/cendres/audio/quarre/source"

            xspread: 0.42
            diffuse: 1.0
            bias: 0.82
            fixed: true
            y: 0.45

            WPN114.Sampler { id: quarre;
                exposePath: "/stonepath/cendres/audio/quarre"
                path: "audio/stonepath/cendres/quarre.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 11.GROUNDWALK (21-22)
        {
            id:         groundwalk_source
            exposePath: "/stonepath/cendres/audio/groundwalk/source"

            WPN114.StreamSampler { id: groundwalk;
                exposePath: "/stonepath/cendres/audio/groundwalk"
                path: "audio/stonepath/cendres/groundwalk.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 12.NECKS (25-26)
        {
            exposePath: "/stonepath/cendres/audio/necks/source"

            xspread: 0.05
            fixed: true
            y: 0.52

            WPN114.Sampler { id: necks;
                exposePath: "/stonepath/cendres/audio/necks"
                path: "audio/stonepath/cendres/necks.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 13.DRAGON (27-28)
        {
            id:         dragon_source
            exposePath: "/stonepath/cendres/audio/dragon/rooms"

            WPN114.StreamSampler { id: dragon;
                exposePath: "/stonepath/cendres/audio/dragon"
                path: "audio/stonepath/cendres/dragon.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -4.47 }
            }
        }

        WPN114.MonoSource //----------------------------------------- 14.BIRDS (29-30)
        {
            id:         birds_source
            exposePath: "/stonepath/cendres/audio/birds/rooms"

            WPN114.MultiSampler { id: birds;
                exposePath: "/stonepath/cendres/audio/birds"
                path: "audio/stonepath/cendres/birds"
                WPN114.Fork { target: effects.reverb; dBlevel: -6 }
            }
        }
    }
}
