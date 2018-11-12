import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property alias server:  query_server
    property alias clients: client_manager

    WPN114.FolderNode
    {
        device: module_server
        recursive: true
        folderPath: "/Users/pchd/Repositories/quarre-server/resources/qml/modules"
        path: "/modules"
        filters: ["*.qml"]
    }

    WPN114.OSCQueryServer
    {
        id: module_server
        name: "quarre-modules"
        tcpPort: 8576
        udpPort: 4132
    }

    WPN114.OSCQueryServer
    {
        id: query_server
        singleDevice: true
        name: "quarre-server"
        tcpPort: 5678
        udpPort: 1234
    }

    ClientManager
    {
        id: client_manager
        maxClients: 4
    }
}
