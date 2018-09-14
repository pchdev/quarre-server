import QtQuick 2.0
import "items"

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
                ossia_modules.sensors_proximity_close = !ossia_modules.sensors_proximity_close
                t_anim.animation.running = true;
            }

            close_triggered = sensor_manager.proximity.reading.near;
        }
    }

    TriggerAnimation { id: t_anim; anchors.fill: parent }
    XYZRotation { id: rotation; visible: false }

}
