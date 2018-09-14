import QtQuick 2.0

Rectangle
{
    id: pad

    property string active_color: "white"
    property string inactive_color: "#294a51"
    property bool pressed: false
    property int pad_index: 0

    color: inactive_color

    function push()
    {
        pad.color = active_color;
    }

    function release()
    {
        pad.color = inactive_color;
    }

    MouseArea
    {
        anchors.fill: parent

        // let parent decide what to do when pressed
        onPressed: pad.pressed  = true;
        onReleased: pad.pressed = false;
    }
}
