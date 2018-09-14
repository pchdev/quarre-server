import QtQuick 2.0
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

    function update(idx, status)
    {
        if ( status )
        {
            ossia_modules.jomon_arp_notes_add = idx;
            ossia_modules.jomon_arp_notes_add = 0;
        }
        else
        {
            ossia_modules.jomon_arp_notes_remove = idx;
            ossia_modules.jomon_arp_notes_remove = 0;
        }
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
