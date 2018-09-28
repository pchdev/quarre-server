import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Node
    {
        type: WPN114.Type.Bool
        path: "audio/wood-path/pando/play"
        onValueReceived:
        {
            pando_rooms.active   = newValue;
        }
    }

    WPN114.Rooms
    {
        id: pando_rooms
        parentStream: audio_stream
        configuration: rooms_config
        active: false

        exposePath: "/audio/wood-path/pando/rooms"

        WPN114.RoomSource //----------------------------------------- 1.FLUTE (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/pando/rooms/sources/flute"

            WPN114.Sampler { id: flute; stream: true;
                path: "audio/wood-path/pando/flute.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.LEAVES (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/pando/rooms/sources/leaves"

            WPN114.Sampler { id: leaves; stream: true;
                path: "audio/wood-path/pando/leaves.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.WOODWORKS (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/pando/rooms/sources/woodworks"

            WPN114.Sampler { id: woodworks; stream: true;
                path: "audio/wood-path/pando/woodworks.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.INSECTS (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/pando/rooms/sources/insects"

            WPN114.Sampler { id: insects; stream: true;
                path: "audio/wood-path/pando/insects.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.DIGIGREEN (9-10)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/pando/rooms/sources/digigreen"

            WPN114.Sampler { id: digigreen; stream: true;
                path: "audio/wood-path/pando/digigreen.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.VERB (11-12)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/pando/rooms/sources/verb"

            WPN114.Sampler { id: verb; stream: true;
                path: "audio/wood-path/pando/verb.wav" }
        }
    }

}
