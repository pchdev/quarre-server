import QtQuick 2.0

GestureViewer
{
    title:          "Paume flottante"
    gestures:       [ "QtSensors.cover" ]

    description:    "Placer votre main tendue au-dessus de l'appareil jusqu'au déclenchement. Celui-ci doit être tenu à plat."
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
            source: "qrc:/modules/palm.png"
        }
    }

    Connections
    {
        target: gesture_manager.backend
        onDetected:
        {
            ossia_modules.gestures_palm_trigger = !ossia_modules.gestures_palm_trigger;
            trigger_animation.running = true
        }
    }
}
