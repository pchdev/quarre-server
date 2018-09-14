import QtQuick 2.0

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    onEnabledChanged:
    {
        sensor_manager.rotation.active = enabled;
        polling_timer.running = enabled;
    }

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered:
            ossia_modules.sensors_rotation_y_angle = sensor_manager.rotation.reading.y

    }

    Image
    {
        id: arrow
        antialiasing: true
        anchors.fill: parent
        source: "qrc:/modules/arrow.png"
        fillMode: Image.PreserveAspectFit

        x: parent.width/2
        y: parent.height/2

        transform: [

            Rotation
            {
                id: rotation
                axis { x: 0; y: 0; z: 1 }
                angle: ossia_modules.sensors_rotation_y_angle
            },

            Scale
            {
                id: scale
                origin.x : width/2
                origin.y: height/2
                xScale: 0.2
                yScale: 0.2
            }
        ]
    }

    Text //---------------------------------------------------------------- ROTATION_PRINT
    {
        id:         rotation_print

        text:       "rotation: " + Math.floor(ossia_modules.sensors_rotation_y_angle) + " degrees"
        color:      "#ffffff"
        width:      parent.width
        height:     parent.height * 0.2
        y:          parent.height * 0.2

        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        font.pointSize:         16 * root.fontRatio
        textFormat:             Text.PlainText
        font.family:            font_lato_light.name
    }
}

