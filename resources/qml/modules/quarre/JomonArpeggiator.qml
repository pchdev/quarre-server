import QtQuick 2.0
import WPN114 1.0 as WPN114
import "items"

Rectangle
{
    id: arp
    anchors.fill: parent
    color: "transparent"

    property var pads: [
        67, 68, 69, 70,
        63, 64, 65, 66,
        59, 60, 61, 62,
        55, 56, 57, 58 ]

    property var notes: []

    WPN114.Node
    {
        id: node_add
        path: "/modules/jomon/arpeggiator/notes/add"
        type: WPN114.Type.Int
        critical: true
    }

    WPN114.Node
    {
        id: node_remove
        path: "/modules/jomon/arpeggiator/notes/remove"
        type: WPN114.Type.Int
        critical: true
    }

    function update(idx, status)
    {
        if ( status ) node_add.value = idx;
        else node_remove.value = idx;
    }

    Grid
    {
        columns: 4
        rows: 4
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater
        {
            id: pad_repeater
            model: pads

            QuarreArpPad
            {
                id:         target
                width:      arp.width/6
                height:     arp.width/6
                pad_index:  modelData
            }
        }
    }

}
