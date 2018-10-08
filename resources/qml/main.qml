import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114 1.0 as WPN114
import "scenes"

ApplicationWindow
{
    visible: true
    width: 640
    height: 480

    WPN114.FolderNode
    {
        device: query_server
        recursive: true
        folderPath: "/Users/pchd/Repositories/quarre-server/resources/qml/modules"
        path: "/modules"
        filters: ["*.png", "*.qml"]
    }

    WPN114.OSCQueryServer
    {
        id: query_server
        singleDevice: true
        name: "quarre-server"
        tcpPort: 5678
        udpPort: 1234
    }

    WPN114.AudioStream //------------------------------------------------------------- AUDIO
    {
        id:             audio_stream
        outDevice:      "Soundflower (64ch)"
        numOutputs:     8
        sampleRate:     44100
        blockSize:      512

        Component.onCompleted:
        {
            introduction.rooms.setup = rooms_setup
            start();
        }

        WPN114.Node on dBlevel { path: "/audio/master/level" }
        WPN114.Node on active { path: "/audio/master/active" }
        WPN114.Node on mute { path: "/audio/master/muted" }
    }

    WPN114.RoomSetup // octophonic ring setup for quarrè-angoulême
    {
        id: rooms_setup;        
        WPN114.SpeakerRing { nspeakers: 8; offset: Math.PI/8; influence: 0.5 }
    }

    Introduction { id: introduction }
}
