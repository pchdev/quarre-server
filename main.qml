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

    WPN114.OSCQueryClient
    {
        zeroConfHost: "quarre-remote"
        onConnected: console.log("connected");
    }

    FileDirectory
    {
        // TODO: recursive
        recursive: true
        path: "/Users/pchd/Repositories/quarre-server/resources/qml/modules/basics"
        Component.onCompleted: module_list.value = fileList;
    }

    WPN114.Node
    {
        id: module_list
        device: module_server
        path: "/modules"
        type: WPN114.Type.List
    }

    WPN114.OSCQueryServer
    {
        id: module_server
        name: "quarre-server"
        tcpPort: 5678
        udpPort: 1234

        onUnknownMethodRequested:
        {
            console.log(method)
            if ( method.contains("/modules"))
                ;
        }
    }
}
