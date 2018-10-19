import QtQuick 2.0
import QtQuick.Controls 2.0
import WPN114 1.0 as WPN114
import "NodeView.js" as NodeView

Item
{
    id: root
    anchors.fill: parent
    property var current: []
    property int ypos: 50

    TextField
    {
        id: textfield
        placeholderText: "Enter path"
        text: "/audio/stonepath/cendres/ashes/functions"

        onAccepted:
        {
            var node = query_server.get(textfield.text)
            clear();

            NodeView.createComponent(root, node);
        }
    }
}
