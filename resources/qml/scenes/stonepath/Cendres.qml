import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- ORAGE_HAMMER
        {
            id:     interaction_thunder

            title:  "Orage, déclenchement"
            path:   "/stonepath/cendres/orage"
            module: "basics/GestureHammer.qml"

            description: "Executez le geste décrit ci-dessous pour déclencher un son d'orage."

            countdown:  10
            length: 20

            mappings: QuMapping
            {
                source: "/gestures/whip/trigger"
                expression: function(v) {
                    thunder.play(Math.floor(Math.random()*thunder.files.length));
                    interaction_thunder.end()
                }
            }
        }

        Interaction //--------------------------------------------- BOILING_PALM
        {
            id:     interaction_boiling

            title:  "Source volcanique, déclenchement"
            path:   "/stonepath/cendres/boiling"
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
            path:   "/stonepath/cendres/marmottes"
            module: "basics/XYTouch.qml"

            description: "Touchez du doigt un endroit de la sphère afin de déclencher
 et de mettre en espace un cri de marmotte."

            countdown: 15
            length: 45

            mappings: QuMapping
            {
                source: "/modules/marmots/trigger"
                expression: function(v) {
                    marmots.play(Math.floor(Math.random()*marmots.files.length));
                    marmots_source.position = [v[1], v[2]];
                }
            }
        }

        Interaction //--------------------------------------------- DRAGON_SPAT
        {
            id:     interaction_dragon

            title:  "Dragon, mise en espace"
            path:   "/stonepath/cendres/dragon"
            module: "basics/XRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son dans l'espace."

            countdown:  20
            length: 80

            mappings: QuMapping
            {
                source: "/sensors/rotation/position2D"
                expression: function(v) { dragon_source.position = v; }
            }
        }

        Interaction //--------------------------------------------- GROUNDWALK
        {
            id:     interaction_groundwalk

            title:  "Bruits de pas, mise en espace"
            path:   "/stonepath/cendres/groundwalk"
            module: "basics/XRotation.qml"

            description: "Orientez votre appareil horizontalement, à 360 degrés
 autour de vous pour identifier et déplacer le son dans l'espace."

            countdown: 20
            length: 60

            mappings: QuMapping
            {
                source: "/sensors/rotation/position2D"
                expression: function(v) { groundwalk_source.position = v; }
            }
        }

        Interaction //--------------------------------------------- BIRDS_TRAJECTORIES
        {
            id: interaction_flying_birds

            title:  "Oiseaux en vol, trajectoires"
            path:   "/stonepath/cendres/boiling"
            module: "basics/GesturePalm.qml"

            description: "Tracez une trajectoire sur la sphère ci-dessous avec votre doigt,
 pendant quelques secondes, puis relachez pour déclencher"

            countdown: 15
            length: 60

            mappings: [
                QuMapping { source: "/modules/trajectories/trigger"
                    expression: function(v) { birds.play(Math.random()*birds.files.length) }},
                QuMapping { source: "/modules/trajectories/position"
                    expression: function(v) { birds_source.position = v; }} ]
        }
    }

    WPN114.Rooms //-------------------------------------------------------------------- AUDIO
    {
        id: cendres_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/audio/stonepath/cendres/rooms"

        WPN114.RoomSource //----------------------------------------- 1.ASHES (1-2)
        {
            exposePath: "/audio/stonepath/cendres/ashes/rooms"

            position:   [ [0.261, 0.294, 0.5], [ 0.754, 0.705, 0.5 ] ]
            diffuse:    [ 0.47, 0.47 ]
            fixed:      true

            WPN114.StreamSampler { id: ashes;
                exposePath: "/audio/stonepath/cendres/ashes"
                path: "audio/stonepath/cendres/ashes.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.REBIRDS_1 (3-4)
        {
            exposePath: "/audio/stonepath/cendres/redbirds-1/rooms"
            position:   [ [0.225, 0.9, 0.5], [ 0.8, 0.9, 0.5 ] ]
            fixed:      true

            WPN114.StreamSampler { id: redbirds_1;
                exposePath: "/audio/stonepath/cendres/redbirds-1"
                path: "audio/stonepath/cendres/redbirds-1.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.REBIRDS_2 (5-6)
        {
            exposePath: "/audio/stonepath/cendres/redbirds-2/rooms"
            position:   [ [0.2, 0.09, 0.5], [ 0.8, 0.08, 0.5 ] ]
            fixed:      true

            WPN114.StreamSampler { id: redbirds_2;
                exposePath: "/audio/stonepath/cendres/redbirds-2"
                path: "audio/stonepath/cendres/redbirds-2.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.LIGHT-BACKGROUND (7-8)
        {            
            exposePath: "/audio/stonepath/cendres/light-background/rooms"

            position:   [ [0.25, 0.25, 0.5], [ 0.75, 0.75, 0.5 ] ]
            diffuse:    [ 0.5, 0.5 ]
            fixed:      true

            WPN114.Sampler { id: light_background;
                exposePath: "/audio/stonepath/cendres/light-background"
                path: "audio/stonepath/cendres/light-background.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.BURN (9-10)
        {
            exposePath: "/audio/stonepath/cendres/burn/rooms"

            position:   [ [0.2, 0.09, 0.5], [ 0.8, 0.08, 0.5 ] ]
            diffuse:    [ 0.7, 0.7 ]
            fixed:      true

            WPN114.StreamSampler { id: burn;
                exposePath: "/audio/stonepath/cendres/burn"
                path: "audio/stonepath/cendres/burn.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.WAVES (11-12)
        {
            exposePath: "/audio/stonepath/cendres/waves/rooms"

            position:   [ [0.08, 0.5, 0.5], [ 0.92, 0.5, 0.5 ] ]
            diffuse:    [ 0.3, 0.4 ]
            fixed:      true

            WPN114.Sampler { id: waves;
                exposePath: "/audio/stonepath/cendres/waves"
                path: "audio/stonepath/cendres/waves.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 7.THUNDER (13-14)
        {
            exposePath: "/audio/stonepath/cendres/thunder/rooms"

            position:   [ [0.25, 0.75, 0.5], [ 0.75, 0.75, 0.5 ] ]
            diffuse:    [ 0.6, 0.6 ]
            fixed:      true

            WPN114.MultiSampler { id: thunder;
                exposePath: "/audio/stonepath/cendres/thunder"
                path: "audio/stonepath/cendres/thunder" }

        }

        WPN114.RoomSource //----------------------------------------- 8.MARMOTS (15-16)
        {
            id:         marmots_source;
            exposePath: "/audio/stonepath/cendres/marmots/rooms"

            WPN114.MultiSampler { id: marmots;
                exposePath: "/audio/stonepath/cendres/marmots"
                path: "audio/stonepath/cendres/marmots" }
        }

        WPN114.RoomSource //----------------------------------------- 9.BOILING (17-18)
        {
            exposePath: "/audio/stonepath/cendres/boiling/rooms"
            position:   [ [0.4, 0.55, 0.5], [ 0.6, 0.55, 0.5 ] ]
            fixed:      true

            WPN114.Sampler { id: boiling;
                exposePath: "/audio/stonepath/cendres/boiling"
                path: "audio/stonepath/cendres/boiling.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 10.QUARRE (19-20)
        {
            exposePath: "/audio/stonepath/cendres/quarre/rooms"

            position:   [ [0.08, 0.45, 0.5], [ 0.92, 0.45, 0.5 ] ]
            diffuse:    [ 1.0, 1.0 ]
            bias:       [ 0.82, 0.82 ]

            fixed:      true

            WPN114.Sampler { id: quarre;
                exposePath: "/audio/stonepath/cendres/quarre"
                path: "audio/stonepath/cendres/quarre.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 11.GROUNDWALK (21-22)
        {
            id:         groundwalk_source
            exposePath: "/audio/stonepath/cendres/groundwalk/rooms"

            WPN114.StreamSampler { id: groundwalk;
                exposePath: "/audio/stonepath/cendres/groundwalk"
                path: "audio/stonepath/cendres/groundwalk.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 12.NECKS (25-26)
        {
            exposePath: "/audio/stonepath/cendres/necks/rooms"
            position:   [ [0.45, 0.52, 0.5], [ 0.55, 0.52, 0.5 ] ]
            fixed:      true

            WPN114.Sampler { id: necks;
                exposePath: "/audio/stonepath/cendres/necks"
                path: "audio/stonepath/cendres/necks.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 13.DRAGON (27-28)
        {
            id:         dragon_source
            exposePath: "/audio/stonepath/cendres/dragon/rooms"

            WPN114.StreamSampler { id: dragon;
                exposePath: "/audio/stonepath/cendres/dragon"
                path: "audio/stonepath/cendres/dragon.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 14.BIRDS (29-30)
        {
            id:         birds_source
            exposePath: "/audio/stonepath/cendres/birds/rooms"

            WPN114.MultiSampler { id: birds;
                exposePath: "/audio/stonepath/cendres/birds"
                path: "audio/stonepath/cendres/birds" }
        }
    }
}
