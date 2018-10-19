import QtQuick 2.0
import WPN114 1.0 as WPN114

import "items"
import "../basics"
import "../basics/items"

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

    WPN114.Node
    {
        id:     node_palm_state
        path:   "/modules/jomon-palmz/cover"
        type:   WPN114.Type.Bool
        value:  false
    }


    ZRotation         { id: z_rotation }
    TriggerAnimation  { id: t_anim; animation.loops: Animation.Infinite; len: 625 }

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
                node_palm_state.value = true;
                t_anim.animation.running = true;
            }

            else if ( !sensor_manager.proximity.reading.near && proximity_state )
            {
                proximity_state = false;
                node_palm_state.value = false;
                t_anim.animation.running = false;
                t_anim.circle.opacity = 0
            }
        }
    }

}
