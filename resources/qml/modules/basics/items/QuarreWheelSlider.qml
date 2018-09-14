import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4

Slider
{
    id: control
    orientation: Qt.Vertical

    property real midValue: 0.5

    onPressedChanged:
        if ( !pressed && !marea.pressed ) value = midValue;

    background: Rectangle
    {
        anchors.fill: parent
        color: "darkgrey"
        border.color: "black"
        border.width: 1
        width: control.availableWidth*0.5
        x: control.availableWidth*0.25
        implicitWidth: control.availableWidth*0.5
    }

    handle: Rectangle
    {
        implicitWidth: control.width
        implicitHeight: implicitWidth
        radius: implicitHeight/2
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        y: control.visualPosition * ( control.height - height )
    }
}
