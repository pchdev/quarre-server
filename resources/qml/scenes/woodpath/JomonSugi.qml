import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: jomon_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_config

        WPN114.RoomSource //----------------------------------------- 1.CICADAS (1-2)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/cicadas/spatialization"

            WPN114.Sampler { id: cicadas; stream: true;
                exposePath: "/audio/wood-path/jomon/cicadas"
                path: "audio/wood-path/vare/cicadas.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.DMSYNTH (3-4)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/dmsynth/spatialization"

            WPN114.Sampler { id: dmsynth; stream: true;
                exposePath: "/audio/wood-path/jomon/dmsynth"
                path: "audio/wood-path/vare/dmsynth.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.LEAVES (5-6)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/leaves/spatialization"

            WPN114.Sampler { id: leaves; stream: true;
                exposePath: "/audio/wood-path/jomon/leaves"
                path: "audio/wood-path/vare/leaves.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.FSYNTHS (7-8)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/fsynths/spatialization"

            WPN114.Sampler { id: fsynths; stream: true;
                exposePath: "/audio/wood-path/jomon/fsynths"
                path: "audio/wood-path/vare/fsynths.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 5.YSYNTHS (9-10)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/ysynths/spatialization"

            WPN114.Sampler { id: ysynths; stream: true;
                exposePath: "/audio/wood-path/jomon/ysynths"
                path: "audio/wood-path/vare/ysynths.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 6.OWL_1 (11-12)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/owl1/spatialization"

            WPN114.Sampler { id: owl1; stream: true;
                exposePath: "/audio/wood-path/jomon/owl1"
                path: "audio/wood-path/vare/owl1.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 7.OWL_2 (13-14)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/owl2/spatialization"

            WPN114.Sampler { id: owl2; stream: true;
                exposePath: "/audio/wood-path/jomon/owl2"
                path: "audio/wood-path/vare/owl2.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 8.OWL_3 (13-14)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/owl3/spatialization"

            WPN114.Sampler { id: owl3; stream: true;
                exposePath: "/audio/wood-path/jomon/owl3"
                path: "audio/wood-path/vare/owl3.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 9.OWL_4 (11-12)
        {
            position:   [ [0.151, 0.5, 0.5], [ 0.835, 0.5, 0.5 ] ]
            diffuse:    [ 0.49, 0.49 ]
            bias:       [ 0.5, 0.5 ]

            exposePath: "/audio/wood-path/jomon/owl4/spatialization"

            WPN114.Sampler { id: owl4; stream: true;
                exposePath: "/audio/wood-path/jomon/owl4"
                path: "audio/wood-path/vare/owl4.wav" }
        }

    }
}
