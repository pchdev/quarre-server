import QtQuick 2.0

Item
{
    anchors.fill: parent

    property alias animation: trigger_animation
    property alias circle: trigger_animation_circle
    property real len: 1250

    Rectangle
    {
        id: trigger_animation_circle
        color: "transparent"
        border.color: "white"
        border.width: 5
        x: parent.width/2 - width/2
        y: parent.height/2 - height/2
    }

    ParallelAnimation
    {
        id: trigger_animation
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "width"
            from: 0
            to: parent.width
            duration: len
        }
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "height"
            from: 0
            to: parent.width
            duration: len
        }
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "radius"
            from: 0
            to: parent.width*0.5
            duration: len
        }
        SequentialAnimation
        {
            NumberAnimation
            {
                target: trigger_animation_circle
                property: "opacity"
                from: 0
                to: 0.8
                duration: len/2
            }
            NumberAnimation
            {
                target: trigger_animation_circle
                property: "opacity"
                from: 0.8
                to: 0
                duration: len/2
            }
        }
    }
}
