import QtQuick 2.0

Rectangle
{
    id: pad

    property int pad_index;
    property bool active: false

    property string active_color:           "white"
    property string inactive_color:         "#294a51"

    color: active ? active_color : inactive_color

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            if ( pad.active )
            {
                pad.color       = inactive_color;
                pad.active      = false;
                arp.update      ( pad_index, false );
            }
            else
            {
                pad.color       = active_color;
                pad.active      = true;
                arp.update      ( pad_index, true );
            }
        }
    }
}
