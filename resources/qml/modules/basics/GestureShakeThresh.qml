import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    property real thresh: 20.0
    anchors.fill: parent
    color: "transparent"

    WPN114.Node
    {
        id: node
        path: "/modules/gestures/shaking"
        type: WPN114.Type.Bool
    }

    onEnabledChanged:
    {
        sensor_manager.accelerometers.active = enabled;
        polling_timer.running = enabled;
    }

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered:
        {
            var xyz = Qt.vector3d( sensor_manager.accelerometers.reading.x,
                                  sensor_manager.accelerometers.reading.y,
                                  sensor_manager.accelerometers.reading.z );

            if ( ( xyz.x >= thresh || xyz.y >= thresh || xyz.z >= thresh )
                 && !node.value )
                 node.value = true;

            else if ( node.value ) node.value = false;


        }
    }

}
