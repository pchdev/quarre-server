import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property alias rooms: jomon_rooms

    WPN114.Rooms
    {
        id: jomon_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        WPN114.StereoSource //----------------------------------------- 1.CICADAS (1-2)
        {
            xspread: 0.2
            diffuse: 0.8
            fixed:  true

            exposePath: "/woodpath/jomon/audio/cicadas/source"

            WPN114.StreamSampler { id: cicadas;
                exposePath: "/woodpath/jomon/audio/cicadas"
                path: "audio/woodpath/jomon/cicadas.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.DMSYNTH (3-4)
        {
            xspread: 0.3
            diffuse: 0.5
            y: 0.9
            fixed:  true

            exposePath: "/woodpath/jomon/audio/dmsynth/source"

            WPN114.Sampler { id: dmsynth;
                exposePath: "/woodpath/jomon/audio/dmsynth"
                path: "audio/woodpath/jomon/dmsynth.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.LEAVES (5-6)
        {
            yspread: 0.25
            diffuse: 0.8
            fixed: true

            exposePath: "/woodpath/jomon/audio/leaves/source"

            WPN114.StreamSampler { id: leaves;
                exposePath: "/woodpath/jomon/audio/leaves"
                path: "audio/woodpath/jomon/leaves.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.FSYNTHS (7-8)
        {
            exposePath: "/woodpath/jomon/audio/fsynths/source"

            WPN114.StreamSampler { id: fsynths;
                exposePath: "/woodpath/jomon/audio/fsynths"
                path: "audio/woodpath/jomon/fsynths.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.YSYNTHS (9-10)
        {
            xspread: 0.3
            diffuse: 0.3
            y: 0.1
            fixed:  true
            exposePath: "/woodpath/jomon/audio/ysynths/source"

            WPN114.Sampler { id: ysynths;
                exposePath: "/woodpath/jomon/audio/ysynths"
                path: "audio/woodpath/jomon/ysynths.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 6.OWL_1 (11-12)
        {
            position: Qt.vector3d(0.3, 0.4, 0.5)
            fixed:  true

            exposePath: "/woodpath/jomon/audio/owl1/source"

            WPN114.Sampler { id: owl1;
                exposePath: "/woodpath/jomon/audio/owl1"
                path: "audio/woodpath/jomon/owl1.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 7.OWL_2 (13-14)
        {
            position: Qt.vector3d(0.15, 0.05, 0.5)
            fixed: true

            exposePath: "/woodpath/jomon/audio/owl2/source"

            WPN114.Sampler { id: owl2;
                exposePath: "/woodpath/jomon/audio/owl2"
                path: "audio/woodpath/vare/owl2.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 8.OWL_3 (15-16)
        {
            position: Qt.vector3d(0.95, 0.5, 0.5)
            fixed: true

            exposePath: "/woodpath/jomon/audio/owl3/source"

            WPN114.Sampler { id: owl3;
                exposePath: "/woodpath/jomon/audio/owl3"
                path: "audio/woodpath/vare/owl3.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 9.OWL_4 (17-18)
        {
            position: Qt.vector3d(0.05, 0.5, 0.5)
            fixed: true

            exposePath: "/woodpath/jomon/audio/owl4/source"

            WPN114.Sampler { id: owl4;
                exposePath: "/woodpath/jomon/audio/owl4"
                path: "audio/woodpath/vare/owl4.wav" }
        }
    }
}
