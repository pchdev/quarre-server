import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    property bool proximity_state: false

    onEnabledChanged:
    {
        sensor_manager.proximity.active = enabled;
        poll.running = enabled;
        z_rotation.enabled = enabled;
    }

    ZRotation { id: z_rotation }

    TriggerAnimation { id: t_anim; animation.loops: Animation.Infinite; len: 625 }

    Timer
    {
        id: poll
        interval: 50
        repeat: true

        onTriggered:
        {
            if ( sensor_manager.proximity.reading.near && !proximity_state )
            {
                proximity_state = true;
                ossia_modules.jomon_palm_state = true;
                t_anim.animation.running = true;
            }

            else if ( !sensor_manager.proximity.reading.near && proximity_state )
            {
                proximity_state = false;
                ossia_modules.jomon_palm_state = false;
                t_anim.animation.running = false;
                t_anim.circle.opacity = 0
            }
        }
    }

}
