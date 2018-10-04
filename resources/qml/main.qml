import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114 1.0 as WPN114
import Quarre 1.0
import "scenes"

ApplicationWindow
{
    visible: true
    width: 640
    height: 480

    WPN114.OSCQueryClient { zeroConfHost: "quarre-remote" }

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
        outDevice:      "Scarlett 2i2 USB"
        sampleRate:     44100
        blockSize:      512

        WPN114.Node on dBlevel { path: "/audio/master/level" }
    }

    WPN114.RoomSetup // octophonic ring setup for quarrè-angoulême
    {
        id: rooms_setup;        
        WPN114.SpeakerRing { nspeakers: 8; offset: Math.PI/8 }
    }

    Introduction {}
}
