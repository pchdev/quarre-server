import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

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
            ossia_modules.sensors_proximity_close = !ossia_modules.sensors_proximity_close
        }
    }

    Connections
    {
        target: gesture_manager.backend
        onDetected: t_anim.animation.running = true
    }

    TriggerAnimation    { id: t_anim; anchors.fill: parent }
    ZRotation           { id: z_rotation }
    XRotation           { id: x_rotation; visible: false }
    GestureShake        { id: gesture_shake; visible: false }
}
