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
        sensor_manager.rotation.active = enabled;
        poll.running = enabled;
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

    TriggerAnimation { id: t_anim; animation.loops: Animation.Infinite; len: 625 }

    Timer
    {
        id: poll
        interval: 50
        repeat: true

        onTriggered:
        {
            ossia_modules.sensors_rotation_xyz_data = Qt.vector3d(
                        sensor_manager.rotation.reading.x,
                        sensor_manager.rotation.reading.y,
                        sensor_manager.rotation.reading.z );

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
