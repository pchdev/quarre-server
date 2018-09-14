import QtQuick 2.0

Rectangle
{
    onEnabledChanged:
    {
        xyz_rotation.enabled = enabled;
        hammer.enabled = enabled;
    }

    color: "transparent"
    anchors.fill: parent

    XYZRotation { id: xyz_rotation; visible: false }
    GestureHammer { id: hammer; visible: true }
}
