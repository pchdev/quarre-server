import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114 1.0 as WPN114
import Quarre 1.0

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

    AudioServer { }
}
