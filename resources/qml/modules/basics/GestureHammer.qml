import QtQuick 2.0

GestureViewer
{
    id: viewer

    title:          "Frappe verticale"
    gestures:       [ "QtSensors.whip" ]

    description:    "Effectuer un geste court et sec vers le bas, comme un marteau. L'appareil doit être à plat (et non sur la tranche)"
    anchors.fill:   parent

    Item
    {
        width: parent.width
        height: parent.height*0.65
        y: parent.height*0.35

        Image //----------------------------------------------------------------- GUI
        {
            id: hand
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "qrc:/modules/hammer.png"
        }
    }

    Connections
    {
        target: gesture_manager.backend
        onDetected:
        {
            ossia_modules.gestures_hammer_trigger = !ossia_modules.gestures_hammer_trigger;
            trigger_animation.running = true
        }
    }
}
