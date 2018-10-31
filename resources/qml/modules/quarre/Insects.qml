import QtQuick 2.0
import WPN114 1.0 as WPN114
import "items"
import "../basics"
import "../basics/items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    WPN114.Node
    {
        id:     node
        path:   "/modules/insects/trigger"
        type:   WPN114.Type.Bool
    }

    onEnabledChanged:
    {
        z_rotation.enabled                  = enabled;
        x_rotation.enabled                  = enabled;
        gesture_shake.enabled               = enabled;
        sensor_manager.proximity.active     = enabled;
        proximity_poll.running              = enabled;
    }

    Timer
    {
        id: proximity_poll
        interval: 50
        repeat: true

        onTriggered:
        {
            if ( sensor_manager.proximity.reading.near )
                 node.value = false
        }
    }

    TriggerAnimation    { id: t_anim; anchors.fill: parent }
    ZRotation           { id: z_rotation }
    XRotation           { id: x_rotation; visible: false }

    GestureShake
    {
        id: gesture_shake;
        visible: false

        onDetected: { node.value = true; t_anim.animation.running = true }
    }
}
