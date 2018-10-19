import QtQuick 2.0
import WPN114 1.0 as WPN114
import "items"
import "../basics/items"
import "../basics"

Rectangle
{
    color: "transparent"
    anchors.fill: parent

    property bool close_triggered: false

    onEnabledChanged:
    {
        rotation.enabled = enabled;
        proximity_poll.running = enabled;
        sensor_manager.proximity.active = enabled;
    }

    WPN114.Node
    {
        id: trigger
        path: "/modules/bells/trigger"
        type: WPN114.Type.Impulse
    }

    Item
    {
        anchors.fill: parent

        Image //----------------------------------------------------------------- GUI
        {
            id: hand
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "qrc:/modules/palm.png"
        }
    }

    Timer
    {
        id: proximity_poll
        interval: 50
        repeat: true

        onTriggered:
        {
            if ( sensor_manager.proximity.reading.near && !close_triggered )
            {
                trigger.value = 0;
                t_anim.animation.running = true;
            }

            close_triggered = sensor_manager.proximity.reading.near;
        }
    }

    TriggerAnimation { id: t_anim; anchors.fill: parent }
    XYZRotation { id: rotation; visible: false }

}
