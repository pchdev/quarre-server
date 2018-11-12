import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."

Item
{
    property string name
    property string path
    property list<Scene> subscenes
    property list<Interaction> interactions

    property WPN114.TimeNode scenario: WPN114.TimeNode
    {
        source: audio_stream
        duration: -1
    }

    property WPN114.Rooms rooms: WPN114.Rooms
    {
        setup: rooms_setup
        parentStream: audio_stream
        active: false
    }

    signal next ( );
    signal end  ( );

}
