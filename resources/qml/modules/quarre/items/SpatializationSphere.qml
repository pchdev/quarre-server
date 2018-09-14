import QtQuick 2.0

Item
{
    anchors.fill: parent

    Image
    {
        id: rose_bg
        antialiasing: true
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: "qrc:/modules/rose2.png"

        transform: Scale
        {
            id: scale
            origin.x: width/2
            origin.y: height/2
        }
    }

    SequentialAnimation
    {
        running: true
        loops: Animation.Infinite

        ParallelAnimation
        {
            NumberAnimation
            {
                target: scale
                property: "xScale"
                from: 1.0; to: 0.9
                duration: 10000
            }

            NumberAnimation
            {
                target: scale
                property: "yScale"
                from: 1.0; to: 0.9
                duration: 10000
            }
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: scale
                property: "xScale"
                from: 0.9; to: 1.0
                duration: 10000
            }
            NumberAnimation
            {
                target: scale
                property: "yScale"
                from: 0.9; to: 1.0
                duration: 10000
            }
        }
    }
}
