import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    onEnabledChanged:
    {
        sensor_manager.rotation.active = enabled;
        polling_timer.running = enabled;
    }

    WPN114.Node
    {
        id:     node
        path:   "/modules/xyzrotation/data"
        type:   WPN114.Type.Vec3f
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
            source: "qrc:/modules/xyz.png"
        }
    }

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered:
        {
            var xyz = Qt.vector3d(sensor_manager.rotation.reading.x,
                                  sensor_manager.rotation.reading.y,
                                  sensor_manager.rotation.reading.z)

            node.value = xyz
        }
    }
}
