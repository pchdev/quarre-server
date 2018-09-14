import QtQuick 2.0

Rectangle
{
    anchors.fill: parent
    color: "transparent"

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
            var xyz = Qt.vector3d(sensor_manager.accelerometers.reading.x,
                                  sensor_manager.accelerometers.reading.y,
                                  sensor_manager.accelerometers.reading.z);

            ossia_modules.sensors_accelerometers_xyz_data = xyz;
        }
    }
}
