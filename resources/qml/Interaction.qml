import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property int idkey: 0
    property string title: ""
    property string description: ""
    property int length: 0
    property int countdown: 0
    property string module: ""
    property string path: ""
    property bool broadcast: false
    property var mappings


    function end()
    {

    }

    WPN114.Node
    {
        path: "/interactions/"+path+"/notify"
        type: WPN114.Type.Impulse

        onValueReceived: ;// incoming interaction
    }

    WPN114.Node
    {
        path: "/interactions/"+path+"/begin"
        type: WPN114.Type.Impulse

        onValueReceived: ;// trigger interaction
    }

    WPN114.Node
    {
        path: "/interactions/"+path+"/end"
        type: WPN114.Type.Impulse

        onValueReceived: ;// end interaction
    }
}
