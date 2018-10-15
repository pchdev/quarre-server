import QtQuick 2.0
import "items"

Rectangle
{
    property int num_pads: 12
    id: module
    color: "transparent"

    Grid
    {
        columns: 4
        rows: 3
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater
        {
            id: pad_repeater
            model: num_pads

            QuarrePad
            {
                id:         target
                width:      module.width/6
                height:     module.width/6
                pad_index:  index

                onPressedChanged:
                {
                    if ( pressed )
                    {
                    }
                }
            }
        }
    }
}
