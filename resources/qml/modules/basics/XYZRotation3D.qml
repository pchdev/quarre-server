import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    property real offset: 0.0
    property real real_angle: 0.0

    anchors.fill: parent
    color: "transparent"

    onEnabledChanged:
    {
        sensor_manager.rotation.active = enabled;
        polling_timer.running = enabled;
    }

    WPN114.Node
    {
        id:     node
        path:   "/modules/rotation3D/position"
        type:   WPN114.Type.Vec3f
    }

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered:
        {
            var sx = sensor_manager.rotation.reading.x;
            var sz = sensor_manager.rotation.reading.z;
            var x = 0, y = 0, z = 0;

            // Z_POSITION ================================

            var z_offset = sz+offset;
            if ( z_offset > 180 ) z_offset -=360;
            else if ( z_offset < -180 ) z_offset += 360;

            z_offset = -z_offset;
            real_angle = z_offset;

            z_offset /= 360;
            z_offset *= Math.PI*2

            x = Math.sin(z_offset);
            y = Math.cos(z_offset);

            // X_POSITION ================================
            // limit to 0-90 (don't go under 0)
            // this will set the amplitude of the circle
            // and the z elevation
            var zph = Math.max(sx/90, 0);
            z = Math.sin(zph*Math.PI/2);
            x = x+(x*-z);
            y = y+(y*-z);

            node.value = Qt.vector3d( Math.abs((x+1)/2), (y+1)/2, z );
        }
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

        MouseArea
        {
            anchors.fill: parent
            onPressed: offset = -sensor_manager.rotation.reading.z;
        }

        transform: [

            Rotation
            {
                id: rotation
                origin.x: parent.width/2
                origin.y: parent.height/2
                angle: real_angle
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

        text:       "rotation: " + Math.floor(real_angle) + " degrees"
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

    Text //---------------------------------------------------------------- ROTATION_PRINT
    {
        id:         calibration_label

        text:       "appuyez sur la flèche pour calibrer le nord"
        color:      "#ffffff"
        width:      parent.width
        height:     parent.height * 0.2
        y:          parent.height * 0.6

        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        font.pointSize:         16 * root.fontRatio
        textFormat:             Text.PlainText
        font.family:            font_lato_light.name
    }
}

