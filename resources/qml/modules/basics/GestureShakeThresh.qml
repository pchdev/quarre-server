import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    id: root
    property real thresh_hi: 12
    property real thresh_low: 9.5

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
            var z = Math.abs(sensor_manager.accelerometers.reading.x);

            if ( z >= thresh_hi && !node.value )
                 node.value = true;

            else if ( z < thresh_low && node.value )
                node.value = false;
        }
    }

}
