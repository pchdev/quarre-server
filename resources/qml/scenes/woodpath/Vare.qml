import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Rooms
    {
        id: vare_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        WPN114.RoomSource //----------------------------------------- 1.SNOWFALL (1-2)
        {
            exposePath: "/audio/woodpath/vare/snowfall/spatialization"

            WPN114.Sampler { id: snowfall; stream: true;
                exposePath: "/woodpath/vare/audio/snowfall"
                path: "audio/woodpath/vare/snowfall.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 2.HAMMER (3-4)
        {
            exposePath: "/audio/woodpath/vare/hammer/spatialization"

            WPN114.Sampler { id: hammer; stream: true;
                exposePath: "/woodpath/vare/audio/hammer"
                path: "audio/woodpath/vare/hammer.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 3.PARORAL (5-6)
        {
            exposePath: "/audio/woodpath/vare/paroral/spatialization"

            WPN114.Sampler { id: paroral; stream: true;
                exposePath: "/woodpath/vare/audio/paroral"
                path: "audio/woodpath/vare/paroral.wav" }
        }

        WPN114.RoomSource //----------------------------------------- 4.DOOMSDAY (7-8)
        {
            exposePath: "/audio/woodpath/vare/doomsday/spatialization"

            WPN114.MultiSampler { id: doomsday; stream: true;
                exposePath: "/woodpath/vare/audio/doomsday"
                path: "audio/woodpath/vare/doomsday.wav" }
        }
    }
}
