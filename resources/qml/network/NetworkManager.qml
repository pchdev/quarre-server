import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property alias server:  query_server
    property alias clients: client_manager

    WPN114.OSCQueryServer //================================================= MAIN_SERVER
    {
        id: query_server
        singleDevice: true
        name: "quarre-server"
        tcpPort: 5678
        udpPort: 1234

        Component.onCompleted:
        {
            mainview.tree.model = nodeTree();
//            query_server.loadPreset("angouleme.json");

//            var nodes = query_server.collectNodes("dBlevel");
//            nodes.forEach(function(node){
//                node.resetValue();
//            })
        }
    }

    ClientManager //========================================================= REMOTES
    {
        id: client_manager
        maxClients: 4
    }

    WPN114.FolderNode //==================================================== MODULES
    {
        device: module_server
        recursive: true
        folderPath: "/Users/pchd/Desktop/quarre-bayonne/quarre-server/resources/qml/modules"
        path: "/modules"
        filters: ["*.qml"]
    }

    WPN114.OSCQueryServer //================================================ MODULE_SERVER
    {
        id: module_server
        name: "quarre-modules"
        tcpPort: 8576
        udpPort: 4132
    }
}
