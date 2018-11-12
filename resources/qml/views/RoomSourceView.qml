import QtQuick 2.0

Item
{
    id: root
    property var node
    anchors.fill: parent

    Rectangle
    {
        id: source_left
        width:   10
        height:  width
        radius:  width/2
        color:  "darkgreen"

        Text
        {
            id: source_left_label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            color: "white"

            font.pointSize: 10
        }
    }

    Rectangle
    {
        id: source_right
        width:   10
        height:  width
        radius:  width/2
        color:  "darkred"

        Text
        {
            id: source_right_label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            color: "white"
            font.pointSize: 10

        }
    }

    Component.onCompleted:
    {
        source_left_label.text = node.parent.name+"_l"
        source_right_label.text = node.parent.name+"_r"

        var pos_l = node.subnode( "left/properties/position" );
        var pos_r = node.subnode( "right/properties/position" );

        console.log(pos_l.value, pos_r.value);

        source_left.x = pos_l.value.x*root.width-5;
        source_left.y = (1-(pos_l.value.y))*root.width-5;

        source_right.x = pos_r.value.x*root.width-5;
        source_right.y = (1-(pos_r.value.y))*root.width-5;

    }
}
