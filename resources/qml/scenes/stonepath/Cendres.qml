import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."

Item
{
    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- ORAGE_HAMMER
        {
            id: orage_hammer
            title: "Orage, déclenchement"
            description: ""

            countdown:  10
            length: 20

            path:   "/stonepath/cendres/orage"
            module: "basics/GestureHammer.qml"
        }

        Interaction //--------------------------------------------- BOILING_PALM
        {
            id: boiling_palm
            title: "Source volcanique, déclenchement"
            description: ""

            countdown:  10
            length: 20

            path:   "/stonepath/cendres/boiling"
            module: "basics/GesturePalm.qml"

        }

        Interaction //--------------------------------------------- DRAGON_SPAT
        {
            id: dragon_spat
            title: "Dragon, mise en espace"
            description: ""

            countdown:  10
            length: 20

            path:   "/stonepath/cendres/dragon"
            module: "basics/XRotation.qml"
        }

        Interaction //--------------------------------------------- BIRDS_TRAJECTORIES
        {
            id: flying_birds
            title: "Oiseaux en vol, trajectoires"
            description: ""

            countdown:  10
            length: 20

            path:   "/stonepath/cendres/boiling"
            module: "basics/GesturePalm.qml"
        }
    }

    WPN114.Rooms //-------------------------------------------------------------------- AUDIO
    {
        id: cendres_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/audio/stone-path/cendres/rooms"

        WPN114.RoomSource //----------------------------------------- 1.ASHES (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/ashes/spatialization"

            WPN114.Sampler { id: ashes; stream: true;
                exposePath: "/audio/stone-path/cendres/ashes"
                path: "audio/stone-path/cendres/ashes.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.REBIRDS_1 (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/redbirds-1/spatialization"

            WPN114.Sampler { id: redbirds_1; stream: true;
                exposePath: "/audio/stone-path/cendres/redbirds-1"
                path: "audio/stone-path/cendres/redbirds-1.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.REBIRDS_2 (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/redbirds-2/spatialization"

            WPN114.Sampler { id: redbirds_2; stream: true;
                exposePath: "/audio/stone-path/cendres/redbirds-2"
                path: "audio/stone-path/cendres/redbirds-2.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.LIGHT-BACKGROUND (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/light-background/spatialization"

            WPN114.Sampler { id: light_background; stream: true;
                exposePath: "/audio/stone-path/cendres/light-background"
                path: "audio/stone-path/cendres/light-background.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.BURN (9-10)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/burn/spatialization"

            WPN114.Sampler { id: burn; stream: true;
                exposePath: "/audio/stone-path/cendres/burn"
                path: "audio/stone-path/cendres/burn.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.WAVES (11-12)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/waves/spatialization"

            WPN114.Sampler { id: waves; stream: true;
                exposePath: "/audio/stone-path/cendres/waves"
                path: "audio/stone-path/cendres/waves.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 7.THUNDER (13-14)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/thunder/spatialization"

            WPN114.Sampler { id: thunder; stream: true;
                exposePath: "/audio/stone-path/cendres/redbirds-2"
                path: "audio/stone-path/cendres/redbirds-2.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 8.MARMOTS (15-16)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/marmots/spatialization"

            WPN114.Sampler { id: marmots; stream: true;
                exposePath: "/audio/stone-path/cendres/marmots"
                path: "audio/stone-path/cendres/marmots.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 9.BOILING (17-18)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/boiling/spatialization"

            WPN114.Sampler { id: boiling; stream: true;
                exposePath: "/audio/stone-path/cendres/boiling"
                path: "audio/stone-path/cendres/boiling.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 10.QUARRE (19-20)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/quarre/spatialization"

            WPN114.Sampler { id: quarre; stream: true;
                exposePath: "/audio/stone-path/cendres/quarre"
                path: "audio/stone-path/cendres/quarre.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 11.GROUNDWALK (21-22)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/groundwalk/spatialization"

            WPN114.Sampler { id: groundwalk; stream: true;
                exposePath: "/audio/stone-path/cendres/groundwalk"
                path: "audio/stone-path/cendres/groundwalk.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 12.NECKS (25-26)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/necks/spatialization"

            WPN114.Sampler { id: necks; stream: true;
                exposePath: "/audio/stone-path/cendres/necks"
                path: "audio/stone-path/cendres/necks.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 13.DRAGON (27-28)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/dragon/spatialization"

            WPN114.Sampler { id: dragon; stream: true;
                exposePath: "/audio/stone-path/cendres/dragon"
                path: "audio/stone-path/cendres/dragon.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 14.BIRDS (29-30)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/stone-path/cendres/birds/spatialization"

            WPN114.Sampler { id: birds; stream: true;
                exposePath: "/audio/stone-path/cendres/birds"
                path: "audio/stone-path/cendres/birds.wav" }
        }
    }
}
