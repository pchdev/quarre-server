import QtQuick 2.0
import Quarre 1.0 as Quarre
import "items"

Rectangle
{
    id: module
    color: "transparent"

    property real rms: 0.0

    onEnabledChanged:
    {
        z_rotation.enabled                  = enabled;
        sensor_manager.microphone.active    = enabled;
        polling_timer.running               = enabled;        
    }

    Timer //-----------------------------------------------------------------------------
    {
        id:             polling_timer
        interval:       50
        repeat:         true
        onTriggered:
        {
            rms = sensor_manager.microphone.rms;
            if ( rms > 0.3 && !ossia_modules.gestures_blow_trigger)
            {
                ossia_modules.gestures_blow_trigger = true;
                anim.animation.running = true;
            }
            else if ( rms < 0.2 && ossia_modules.gestures_blow_trigger )
                 ossia_modules.gestures_blow_trigger = false;
        }
    }

    // -------------------------------------------------------------------------------------------

    ZRotation { id: z_rotation }
    TriggerAnimation { id: anim }
}
