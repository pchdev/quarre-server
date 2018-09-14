import QtQuick 2.0

Rectangle
{
    property int cursor: 0
    property var texts: [];

    Text //------------------------------------------------ TEXT_VIEWER
    {
        id:         text_viewer
        y:          parent.height/2
        text:       texts[0]
        color:      "#ffffff"
        height:     parent.height/2
        width:      parent.width * 0.9
        wrapMode:   Text.WordWrap

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignVCenter
        anchors.fill:               parent
        font.pointSize:             24 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true
    }

    /*Ossia.Callback
    {
        id:         text_callback
        device:     ossia_net.client
        node:       "/user/" + ossia_net.slot + "/text-viewer/cursor/set"
        onValueChanged:
        {
            cursor = value;
            text_viewer.text = texts[value];
        }
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       "/user/" + ossia_net.slot + "/text-viewer/cursor/get"
        on:         cursor
    }*/

    MouseArea
    {
        id: mouse_area
        anchors.fill: parent
        onClicked:
        {
            if ( mouseX >= width*0.7 )
            {
                cursor++;
                if ( cursor > texts.length-1 )
                    cursor = 0;
            }

            else if ( mouseX <= width*0.3 )
            {
                cursor--;
                if ( cursor < 0 )
                    cursor = texts.length-1;
            }

            text_viewer.text = texts[cursor];
        }
    }
}
