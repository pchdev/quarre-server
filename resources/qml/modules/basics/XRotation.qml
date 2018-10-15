import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    WPN114.Node
    {
        id:     xrotation_node
        path:   "/modules/xrotation/normalized"
        type:   WPN114.Type.Float
    }

    onEnabledChanged:
    {
        sensor_manager.rotation.active = enabled;
        polling_timer.running = enabled;
    }

    Text //------------------------------------------------ GESTURE_LABEL
    {
        id:         gesture_label
        y:          parent.height*0.05
        width:      parent.width
        height:     parent.height
        color:      "#ffffff"
        text:       "Rotation verticale"

        horizontalAlignment:    Text.AlignHCenter
        font.family:            font_lato_light.name
        font.pointSize:         34 * root.fontRatio
        textFormat:             Text.PlainText

        antialiasing: true
    }

    Text //------------------------------------------------ GESTURE_DESCRIPTION
    {
        id:         gesture_description
        y:          parent.height * 0.2
        text:       "pointez l'avant de votre appareil vers le plafond, ou vers le sol"
        color:      "#ffffff"
        height:     parent.height/2
        width:      parent.width * 0.9
        wrapMode:   Text.WordWrap

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignTop
        anchors.horizontalCenter:   parent.horizontalCenter
        font.pointSize:             14 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true
    }

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered:
            xrotation_node.value = sensor_manager.rotation.reading.x/90

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
                origin.x: width/2
                origin.y: height/2
                axis { x: 1; y: 0; z: 0 }
                angle: -sensor_manager.rotation.reading.x
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

        text:       "rotation: " + Math.floor(sensor_manager.rotation.reading.x) + " degrees"
        color:      "#ffffff"
        width:      parent.width
        height:     parent.height * 0.2
        y:          parent.height * 0.27

        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        font.pointSize:         16 * root.fontRatio
        textFormat:             Text.PlainText
        font.family:            font_lato_light.name
    }
}

